//
//  AppManagerExampleRouter.swift
//  PreventLookingScreen_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AppManagerExampleRouter {
    
    public let navigationController: UINavigationController
    
    init() {

        let mapScreen = AppManagerExampleViewController.initFromItsStoryboard()
        let nvc = UINavigationController(rootViewController: mapScreen)
        
        nvc.tabBarItem = TabBarItem(title: "App manager",
                                    image: UIImage(named: ""),
                                         tag: 0)
        
        nvc.navigationBar.isHidden = true
        nvc.modalPresentationStyle = .fullScreen
        //disable pop swipe from left to right
        nvc.interactivePopGestureRecognizer?.isEnabled = false
        
        self.navigationController = nvc
    }

}
