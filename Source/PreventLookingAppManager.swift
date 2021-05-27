//
//  PreventLookingAppManager.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 07.05.2021.
//

import Foundation

/// A singletone of PreventLookingManager. Can be used only for all the app. Object can be subscribed for warning nitifications
open class PreventLookingAppManager {
    
    public static let shared = PreventLookingManager()
    
    private init() {
        
    }
    
    public static func configure(with config: PreventLookingManagerConfig = PreventLookingManagerConfig()) {
        shared.configure(with: config)
    }
    
}
