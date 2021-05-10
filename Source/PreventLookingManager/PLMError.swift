//
//  PLMError.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 05.05.2021.
//

import Foundation

enum PLMError: Error {
    
    case sessionNotAuthorized
    case sessionConfigurationError
    
    var message: String {
        switch self {
        case .sessionNotAuthorized:
            return "the user has denied access to the camera"
            
        case .sessionConfigurationError:
            return "something goes wrong during capture session configuration"
        }
    }
}
