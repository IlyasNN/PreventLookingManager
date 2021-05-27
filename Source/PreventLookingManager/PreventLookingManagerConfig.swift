//
//  PLMConfig.swift
//  Pods
//
//  Created by Илья Соловьёв on 04.05.2021.
//

import Foundation
import AVFoundation

/// A config file used to setup `PreventLookingManager`. Use this method to change configuration before starting or during the work of the manager
open class PreventLookingManagerConfig {
    
    var timeout: Int
    var minimumSpeed: Double?
    var camera: AVCaptureDevice.Position
    
    /// A config file used to setup `PreventLookingManager`. Use this method to change configuration before starting or during the work of the manager
    public init(timeout: Int = 10,
         minimumSpeed: Double? = nil,
         camera: AVCaptureDevice.Position = .front) {
        self.timeout = timeout
        self.minimumSpeed = minimumSpeed
        self.camera = camera
    }
}
