//
//  PLMDelegate.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 05.05.2021.
//

import Foundation

/// The delegate of a PreventLookingManager object must adopt this protocol and implement at least some of its methods to let manager works correctly
public protocol PreventLookingManagerDelegate {
    
    /// Notification that the user is looking at the screen for more than a timeout
    func gotWarning()
    /// Warning that an error occurred while the manager was working
    func gotError(_ error: Error)
    
    /// Use this method to get images from video stream
    func videoImage(videoImage: UIImage?)
    /// Use this method to get face images from video stream
    func faceDetected(faceImage: UIImage?)
    
}

public extension PreventLookingManagerDelegate {
    
    func videoImage(videoImage: UIImage?) { }
    func faceDetected(faceImage: UIImage?) { }
    
}
