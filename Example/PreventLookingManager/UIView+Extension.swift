//
//  UIView+Extension.swift
//  PreventLookingScreen_Example
//
//  Created by Илья Соловьёв on 08.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
    
    static func getName() -> String {
        String(describing: self)
    }
    
    static func getIdentifier() -> String {
        return String.init(describing: self) + "Identifier"
    }
    
    static private var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    func loadNib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
    }
    
    @discardableResult
    func addBottomLayoutMargin(to viewController: UIViewController, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            let guide = viewController.view.safeAreaLayoutGuide
            constraint =  self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: constant)
            NSLayoutConstraint.activate([constraint])
        } else {
            constraint = self.bottomAnchor.constraint(equalTo: viewController.bottomLayoutGuide.topAnchor,
                                                      constant: constant)
            NSLayoutConstraint.activate([constraint])
        }
        return constraint
    }
    
    @discardableResult
    func addTopLayoutMargin(to viewController: UIViewController, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            let guide = viewController.view.safeAreaLayoutGuide
            constraint = self.topAnchor.constraint(equalTo: guide.topAnchor, constant: constant)
            NSLayoutConstraint.activate([constraint])
        } else {
            constraint = self.topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor,
                                                   constant: constant)
            NSLayoutConstraint.activate([constraint])
        }
        return constraint
    }
    
}

