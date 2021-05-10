//
//  Storyboard+UIViewController.swift
//  PreventLookingScreen_Example
//
//  Created by Илья Соловьёв on 07.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UIViewController: StoryboardLoadable {
    @objc public func didLoadFromStoryboard() {
        // Is Abstract method
    }
}

public protocol StoryboardLoadable {
    static func initFromItsStoryboard() -> Self
    func didLoadFromStoryboard()
}

extension StoryboardLoadable where Self: UIViewController {
    
    public static func initFromItsStoryboard() -> Self {
        let storyboardName = String(describing: self)
        return initFromStoryboard(name: storyboardName)
    }
    
    static func initFromStoryboard(name: String, withIdentifier identifier: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiate(self, withIdentifier: identifier)
        viewController.didLoadFromStoryboard()
        return viewController
    }
}

extension UIStoryboard {
    
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type, withIdentifier identifier: String? = nil) -> VC {
        guard let identifier = identifier else {
            guard let vc = instantiateInitialViewController() as? VC else {
                fatalError("Couldn't instantiate \(type(of: VC.self))")
            }
            return vc
        }
        
        guard let vc = instantiateViewController(withIdentifier: identifier) as? VC else {
            fatalError("Couldn't instantiate \(type(of: VC.self))")
        }
        
        return vc
    }
}



