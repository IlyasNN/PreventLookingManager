//
//  DesignableView.swift
//  PreventLookingScreen_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

//  Inspiered by:
//  https://medium.com/@vialyx/import-uikit-custom-ibdesignable-uiview-cd26cf7e606c

import UIKit

// Needed to make changes visible on storyboard
@IBDesignable
final class DesignableView: UIView {
}

@IBDesignable
final class DesignableTableView: UITableView {
}

@IBDesignable
final class DesignableTextView: UITextView {
}

@IBDesignable
final class DesignableButton: UIButton {
}

@IBDesignable
final class DesignableScrollView: UIScrollView {
}

extension UIView {
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            } else {
                return UIColor.clear
            }
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
}

// MARK: - Corners
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            
//            let masksToBounds = newValue > 0 && shadowColor == nil
//            layer.masksToBounds = masksToBounds
        }
    }
    
    // Not ready
    // TODO: https://vispud.blogspot.com/2019/04/how-to-set-cornerradius-for-only-bottom.html
    @IBInspectable
    var maskedCorners: CACornerMask {
        get {
            layer.maskedCorners
        }
        set {
            layer.maskedCorners = newValue
        }
    }
    
    @IBInspectable
    var topLeftCorner: Bool {
        get {
            haveCornerMask(.layerMinXMinYCorner)
        }
        set {
             setCornerMask(.layerMinXMinYCorner, shouldSet: newValue)
        }
    }
    
    @IBInspectable
    var topRightCorner: Bool {
        get {
            haveCornerMask(.layerMaxXMinYCorner)
        }
        set {
             setCornerMask(.layerMaxXMinYCorner, shouldSet: newValue)
        }
    }
    
    @IBInspectable
    var bottomLeftCorner: Bool {
        get {
            haveCornerMask(.layerMinXMaxYCorner)
        }
        set {
             setCornerMask(.layerMinXMaxYCorner, shouldSet: newValue)
        }
    }
    
    @IBInspectable
    var bottomRightCorner: Bool {
        get {
            haveCornerMask(.layerMaxXMaxYCorner)
        }
        set {
             setCornerMask(.layerMaxXMaxYCorner, shouldSet: newValue)
        }
    }
    
    private func haveCornerMask(_ cornerMask: CACornerMask) -> Bool {
        layer.maskedCorners.contains(cornerMask)
    }
    
    private func setCornerMask(_ cornerMask: CACornerMask, shouldSet: Bool) {
        var maskedCorners = layer.maskedCorners
        if shouldSet {
            maskedCorners.insert(cornerMask)
        } else {
            maskedCorners.remove(cornerMask)
        }
        layer.maskedCorners = maskedCorners
    }
}

// MARK: - Shadow
extension UIView {
    
    @IBInspectable
    var masksToBounds: Bool {
        set {
            layer.masksToBounds = newValue
        }
        get {
            return layer.masksToBounds
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            layer.shadowOpacity
        }
    }
    
    @IBInspectable
    var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
}
