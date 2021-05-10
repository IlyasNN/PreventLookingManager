//
//  PLVC+Vision.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 05.05.2021.
//

import Foundation
import AVFoundation
import Vision

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension PreventLookingManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
              let exifOrientation = CGImagePropertyOrientation(rawValue: Helper.exifOrientationFromDeviceOrientation(for: cameraPosition)) else { return }
        var requestOptions: [VNImageOption : Any] = [:]
        
        var cimage: CIImage = CIImage(cvPixelBuffer: pixelBuffer)
        cimage = cimage.oriented(exifOrientation)
        let cgImage = Helper.convertCIImageToCGImage(inputImage: cimage)
        
        if let cameraIntrinsicData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
            requestOptions = [.cameraIntrinsics : cameraIntrinsicData]
        }
        
        let req = VNDetectFaceRectanglesRequest { request, error in
            guard error == nil else {
//                completion(.failure(error!))
                return
            }
            
            
            self.delegate?.videoImage(videoImage: Helper.convertCGImageToUIImage(inputImage: cgImage))
            
            let faceImages = request.results?.map({ result -> CGImage? in
                guard let face = result as? VNFaceObservation else { return nil }
                
                let width = face.boundingBox.width * CGFloat(cgImage!.width)
                let height = face.boundingBox.height * CGFloat(cgImage!.height)
                let x = face.boundingBox.origin.x * CGFloat(cgImage!.width)
                let y = (1 - face.boundingBox.origin.y) * CGFloat(cgImage!.height) - height
                
                let croppingRect = CGRect(x: x, y: y, width: width, height: height)
                let faceImage = cgImage!.cropping(to: croppingRect)
                
                return faceImage
            }).compactMap { $0 }
            
            guard let result = faceImages, result.count > 0 else {
                return
            }
            
            self.delegate?.faceDetected(faceImage: Helper.convertCGImageToUIImage(inputImage: result.first!))
            
            let modelConfiguration = MLModelConfiguration()
                
            guard let model = try? VNCoreMLModel(for: EyesDetection1902(configuration: modelConfiguration).model) else {
                return
            }
            
            let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
                
                // TODO: check the error
                
                //print(finishedRequest.results)
                
                guard let detections = finishedRequest.results as? [VNRecognizedObjectObservation] else {
                    return
                }
                
                for detection in detections {
                    print(detection.labels.map({"\($0.identifier) confidence \($0.confidence)"}).joined(separator: "\n"))
                    print("------------------")
                }
                
//                DispatchQueue.main.async {
//                    guard let detection = detections.first?.labels.first else {
//                        self.label.text = "empty detection"
//                        return
//                    }
//                    self.label.text = "\(detection.identifier) \(detection.confidence * 100)%"
//                }
                
                guard let detection = detections.first?.labels.first else {
                    return
                }
                
                switch detection.identifier {
                case "open":
                    self.currentState = .openEyes
                case "closed":
                    self.currentState = .closedEyes
                default:
                    self.currentState = .empty
                }
                
    //            print(results)
    //
    //            let confidenceString = String(format: "%.0f", firstObservation.confidence*100)
    //
    //            DispatchQueue.main.async {
    //                self.textLabel.text = "\(firstObservation.labels) \(confidenceString)%"
    //            }
                
            }
            
            try? VNImageRequestHandler(cgImage: result.first!, options: [:]).perform([request])
//
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: requestOptions)
        
        do {
            try imageRequestHandler.perform([req])
        }
            
        catch {
            print(error)
        }
        
    }
    
}
