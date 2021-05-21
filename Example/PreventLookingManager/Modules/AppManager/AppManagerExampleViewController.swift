//
//  AppManagerExampleViewController.swift
//  PreventLookingManager_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import PreventLookingManager

class AppManagerExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        PreventLookingAppManager.shared.didGetWarning.addListener(skipCurrent: true) { [weak self] _ in
            self?.showAlert(title: "App manager notification",
                            message: "This notification is recieved from the main PreventLookingAppManager (sigleton) to which this controller is subscribed")
        }
        
    }

}
