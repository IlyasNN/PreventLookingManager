//
//  PLVC+VideoSession.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 05.05.2021.
//

import Foundation
import AVFoundation
import Vision

// MARK: -- Video Sessions

// Session Management
enum SessionSetupResult {
    case success
    case notAuthorized
    case configurationFailed
}

extension PreventLookingManager {
    
    
    func configureSession() {
        if setupResult != .success { return }
        
        session.beginConfiguration()
        session.sessionPreset = .high
        
        // Add video input.
        addVideoDataInput()
        
        // Add video output.
        addVideoDataOutput()
        
        session.commitConfiguration()
        
    }
    
    private func addVideoDataInput() {
        do {
            var defaultVideoDevice: AVCaptureDevice!
            
            if cameraPosition == .front {
                if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
                    defaultVideoDevice = frontCameraDevice
                }
            }
            else {
                // Choose the back dual camera if available, otherwise default to a wide angle camera.
                if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: AVMediaType.video, position: .back) {
                    defaultVideoDevice = dualCameraDevice
                }
                
                else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
                    defaultVideoDevice = backCameraDevice
                }
            }
            
            // FIXME: Add device input error
            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice!)
            
            if let currentCameraInput: AVCaptureInput = session.inputs.first {
                session.removeInput(currentCameraInput)
            }
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            }
            
        }
        catch {
            delegate?.gotError(PLMError.sessionConfigurationError)
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
    }
    
    func addVideoDataOutput() {
        videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): Int(kCVPixelFormatType_32BGRA)]
        
        if let currentVideoOutput: AVCaptureOutput = session.outputs.first {
            session.removeOutput(currentVideoOutput)
        }
        
        if session.canAddOutput(videoDataOutput) {
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
            session.addOutput(videoDataOutput)
        } else {
            delegate?.gotError(PLMError.sessionConfigurationError)
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
    }
}
