//
//  Array+Extension.swift
//  PreventLookingScreen_Example
//
//  Created by Илья Соловьёв on 08.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

extension Array {
    var trueEndIndex: Int {
        return  self.count == 0 ? 0 : self.index(before: self.endIndex)
    }
    
}

// Inspiered by:
// https://www.hackingwithswift.com/example-code/language/how-to-make-array-access-safer-using-a-custom-subscript
extension Array {
    
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        
        return self[index]
    }
    
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
    
}

