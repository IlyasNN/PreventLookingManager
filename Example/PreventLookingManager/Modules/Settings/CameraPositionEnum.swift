//
//  CameraPositionEnum.swift
//  PreventLookingManager_Example
//
//  Created by Илья Соловьёв on 28.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import AVKit

enum CameraPosition {
    case unknown
    case front
    case back
    
    func getAppleCameraPosition() -> AVCaptureDevice.Position {
        switch self {
        case .unknown:
            return .unspecified
        case .front:
            return .front
        case .back:
            return .back
        }
    }
    
    static func getByIndex(_ index: Int) -> CameraPosition {
        switch index {
        case 0:
            return .front
        case 1:
            return .back
        default:
            return .unknown
        }
    }
    
}
