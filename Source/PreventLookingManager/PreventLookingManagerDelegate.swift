//
//  PLMDelegate.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 05.05.2021.
//

import Foundation

public protocol PreventLookingManagerDelegate {
    
    func gotWarning()
    func gotError(_ error: Error)
    
    func videoImage(videoImage: UIImage?)
    func faceDetected(faceImage: UIImage?)
    
}

public extension PreventLookingManagerDelegate {
    
    func videoImage(videoImage: UIImage?) { }
    func faceDetected(faceImage: UIImage?) { }
    
}
