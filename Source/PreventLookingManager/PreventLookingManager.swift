//
//  PreventLookingManager.swift
//  Pods
//
//  Created by Илья Соловьёв on 04.05.2021.
//

import UIKit
import AVFoundation
import Vision
import CoreLocation

open class PreventLookingManager: NSObject {
    
    open var delegate: PLMDelegate?
    
    open var didGetWarning: Property<Bool> = .init(false)
    
    private var requests = [VNRequest]()
    
    // VNRequest: Either Retangles or Landmarks
    private var faceDetectionRequest: VNRequest!
    
    var time = 0.0
    var timer: Timer?
    
    // XR - 16
    // 6 - 1.5
    let shotFrequency = 16
    
    var minimumSpeed: Double?
    let locationManager = CLLocationManager();
    var lastLocation:CLLocation?
    var currentSpeed: Double = 0
    
    @objc func action() {
        time += 0.1
    }
    
    var cameraPosition: AVCaptureDevice.Position = .front
    {
        didSet {
            sessionQueue.async { [unowned self] in
                self.configureSession()
            }
        }
    }
    
    private var frameRate = UIDevice().frameRate
    
    private var bufferSize = 10
    
    private var commandBuffer: [States] = []
    var currentState: States = .empty {
        didSet {
            commandBuffer.append(currentState)
            if commandBuffer.count > bufferSize {
                commandBuffer.remove(at: 0)
                
                if commandBuffer.filter({ $0 == States.empty }).count > Int(Double(bufferSize) * 0.7) {
                    commandBuffer.removeAll()
                }
                
                if commandBuffer.filter({ $0 == States.openEyes }).count > Int(Double(bufferSize) * 0.7) {
                    delegate?.gotWarning()
                    self.didGetWarning.value = true
                    print("time - \(time)")
                    time = 0
                    commandBuffer.removeAll()
                }
            }
        }
    }
    
    let session = AVCaptureSession()
    var isSessionRunning = false
    
    // Communicate with the session and other session objects on this queue.
    let sessionQueue = DispatchQueue(label: "session queue", attributes: [], target: nil)
    
    var setupResult: SessionSetupResult = .success
    
    var videoDeviceInput: AVCaptureDeviceInput!
    
    var videoDataOutput: AVCaptureVideoDataOutput!
    var videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
    
    //-------------------------------------
    
    // FIXME: add config
    public func configure(with config: PLMConfig) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        
        self.cameraPosition = config.camera
        self.bufferSize = config.timeout * frameRate
        
        self.minimumSpeed = config.minimumSpeed
        locationManager.delegate = self
        if minimumSpeed != nil {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        /*
         Check video authorization status. Video access is required and audio
         access is optional. If audio access is denied, audio is not recorded
         during movie recording.
         */
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video){
        case .authorized:
            // The user has previously granted access to the camera.
            break
            
        case .notDetermined:
            /*
             The user has not yet been presented with the option to grant
             video access. We suspend the session queue to delay session
             setup until the access request has completed.
             */
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [unowned self] granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
            
            
        default:
            // The user has previously denied access.
            setupResult = .notAuthorized
        }
        
        /*
         Setup the capture session.
         In general it is not safe to mutate an AVCaptureSession or any of its
         inputs, outputs, or connections from multiple threads at the same time.
         
         Why not do all of this on the main queue?
         Because AVCaptureSession.startRunning() is a blocking call which can
         take a long time. We dispatch session setup to the sessionQueue so
         that the main queue isn't blocked, which keeps the UI responsive.
         */
        
        sessionQueue.async { [unowned self] in
            self.configureSession()
        }
        
        sessionQueue.async { [unowned self] in
            switch self.setupResult {
            case .success:
                // Only setup observers and start the session running if setup succeeded.
                self.addObservers()
                self.session.startRunning()
                self.isSessionRunning = self.session.isRunning
                
            case .notAuthorized:
                delegate?.gotError(PLMError.sessionNotAuthorized)
                
            case .configurationFailed:
                delegate?.gotError(PLMError.sessionConfigurationError)
            }
        }
    }
    
    public func deconfigure() {
        sessionQueue.async { [unowned self] in
            if self.setupResult == .success {
                self.session.stopRunning()
                self.isSessionRunning = self.session.isRunning
                self.removeObservers()
            }
        }
    }
    
}
