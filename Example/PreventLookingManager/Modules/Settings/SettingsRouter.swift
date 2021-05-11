//
//  SettingsRouter.swift
//  PreventLookingManager_Example
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
        nvc.navigationBar.barTintColor = UIColor.blue
        nvc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        nvc.tabBarItem = TabBarItem(title: "Настройки",
                                         image: UIImage(named: "tabBar.settings"),
                                         tag: 1)
        
        nvc.navigationBar.isHidden = true
        nvc.modalPresentationStyle = .fullScreen
        
        self.navigationController = nvc
    }

}
