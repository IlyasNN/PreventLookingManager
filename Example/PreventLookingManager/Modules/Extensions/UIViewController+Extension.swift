//
//  UIViewController+Extension.swift
//  PreventLookingManager_Example
//
//  Created by Илья Соловьёв on 12.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String,
                   message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Great! It works!",
                                      style: .default,
                                      handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
