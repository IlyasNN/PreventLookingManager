//
//  PreventLookingAppManager.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 07.05.2021.
//

import Foundation

open class PreventLookingAppManager {
    
    public static let shared = PreventLookingManager()
    
    private init() {
        
    }
    
    public static func configure(with config: PLMConfig = PLMConfig()) {
        shared.configure(with: config)
    }
    
}
