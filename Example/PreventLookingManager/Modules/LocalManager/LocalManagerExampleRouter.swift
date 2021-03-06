//
//  LocalManagerExampleRouter.swift
//  PreventLookingManager_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LocalManagerExampleRouter {
    
    public let navigationController: UINavigationController
    
    init() {

        let mapScreen = LocalManagerExampleViewController.initFromItsStoryboard()
        let nvc = UINavigationController(rootViewController: mapScreen)
        
        nvc.tabBarItem = TabBarItem(title: "Local manager",
                                         image: UIImage(named: "tabBar.phone"),
                                         tag: 0)
        
        nvc.navigationBar.isHidden = true
        nvc.modalPresentationStyle = .fullScreen
        
        self.navigationController = nvc
    }

}
