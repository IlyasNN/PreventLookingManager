//
//  LocalManagerExampleViewController.swift
//  PreventLookingManager_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import PreventLookingManager

class LocalManagerExampleViewController: UIViewController {
    
    let preventLookingManager = PreventLookingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plmConfig = PreventLookingManagerConfig(timeout: 10,
                                                    camera: .front)
        preventLookingManager.configure(with: plmConfig)
        preventLookingManager.delegate = self
    }
    
}

extension LocalManagerExampleViewController: PreventLookingManagerDelegate {
    
    func gotWarning() {
        self.showAlert(title: "Local manager notification",
                       message: "This notification is recieved from local PreventLookingManager via delegate methods")
    }
    
    func gotError(_ error: Error) {
        self.showAlert(title: "Error", message: error.localizedDescription)
    }
    
}
