//
//  Helper.swift
//  Pods
//
//  Created by Илья Соловьёв on 04.05.2021.
//

import Foundation
import AVFoundation

class Helper {
    
    static func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
    static func convertCGImageToUIImage(inputImage: CGImage?) -> UIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        var orientation: UIImage.Orientation
        
        switch UIDevice.current.orientation {
        case .portraitUpsideDown:
            orientation = .down
        case .landscapeLeft:
            orientation = .right
        case .landscapeRight:
            orientation = .up
        default:
            orientation = .up
        }
        
        return UIImage(cgImage: inputImage, scale: 1, orientation: orientation)
        
    }
    
    static func exifOrientationFromDeviceOrientation(for devicePosition: AVCaptureDevice.Position) -> UInt32 {
        enum DeviceOrientation: UInt32 {
            case top0ColLeft = 1
            case top0ColRight = 2
            case bottom0ColRight = 3
            case bottom0ColLeft = 4
            case left0ColTop = 5
            case right0ColTop = 6
            case right0ColBottom = 7
            case left0ColBottom = 8
        }
        var exifOrientation: DeviceOrientation
        
        switch UIDevice.current.orientation {
        case .portraitUpsideDown:
            exifOrientation = devicePosition == .front ? .bottom0ColLeft : .top0ColLeft
        case .landscapeLeft:
            exifOrientation = devicePosition == .front ? .bottom0ColLeft : .top0ColLeft
        case .landscapeRight:
            exifOrientation = devicePosition == .front ? .top0ColRight : .bottom0ColRight
        default:
            exifOrientation = devicePosition == .front ? .left0ColTop : .right0ColTop
        }
        return exifOrientation.rawValue
    }
    
}
