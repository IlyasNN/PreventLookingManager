//
//  SettingsRouter.swift
//  PreventLookingScreen_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class SettingsRouter {
    
    public let navigationController: UINavigationController
    
    init() {

        let settingsScreen = SettingsViewController.initFromItsStoryboard()
        let nvc = UINavigationController(rootViewController: settingsScreen)
        
        nvc.tabBarItem = TabBarItem(title: "Настройки",
                                         image: UIImage(named: "tabBar.settings"),
                                         tag: 1)
        
        nvc.navigationBar.isHidden = true
        nvc.modalPresentationStyle = .fullScreen
        //disable pop swipe from left to right
        nvc.interactivePopGestureRecognizer?.isEnabled = false
        
        self.navigationController = nvc
    }

}
