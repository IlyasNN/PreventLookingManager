//
//  PLMConfig.swift
//  Pods
//
//  Created by Илья Соловьёв on 04.05.2021.
//

import Foundation
import AVFoundation

open class PreventLookingManagerConfig {
    
    var timeout: Int
    var minimumSpeed: Double?
    var camera: AVCaptureDevice.Position
    
    public init(timeout: Int = 10,
         minimumSpeed: Double? = nil,
         camera: AVCaptureDevice.Position = .front) {
        self.timeout = timeout
        self.minimumSpeed = minimumSpeed
        self.camera = camera
    }
}
