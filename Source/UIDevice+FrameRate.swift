//
//  UIDevice+FrameRate.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 08.05.2021.
//

import UIKit

public extension UIDevice {
    
    enum DeviceModelName: String {
        
        case undefined
        case iPodTouch5
        case iPodTouch6
        case iPhone4
        case iPhone4s
        case iPhone5
        case iPhone5c
        case iPhone5s
        case iPhone6
        case iPhone6Plus
        case iPhone6s
        case iPhone6sPlus
        case iPhone7
        case iPhone7Plus
        case iPhoneSE
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXS
        case iPhoneXSMax
        case iPhoneXR
        case iPad2
        case iPad3
        case iPad4
        case iPadAir
        case iPadAir2
        case iPad5
        case iPad6
        case iPadMini
        case iPadMini2
        case iPadMini3
        case iPadMini4
        case iPadPro97Inch
        case iPadPro129Inch
        case iPadPro129Inch2ndGen
        case iPadPro105Inch
        case iPadPro11Inch
        case iPadPro129Inch3rdGen
        case AppleTV
        case AppleTV4K
        case HomePod
    }
    
    /// pares the deveice name as the standard name
    var modelName: DeviceModelName {
        
        #if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
        #else
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        #endif
        
        switch identifier {
        case "iPod5,1":                                 return .iPodTouch5
        case "iPod7,1":                                 return .iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return .iPhone4
        case "iPhone4,1":                               return .iPhone4s
        case "iPhone5,1", "iPhone5,2":                  return .iPhone5
        case "iPhone5,3", "iPhone5,4":                  return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                  return .iPhone5s
        case "iPhone7,2":                               return .iPhone6
        case "iPhone7,1":                               return .iPhone6Plus
        case "iPhone8,1":                               return .iPhone6s
        case "iPhone8,2":                               return .iPhone6sPlus
        case "iPhone9,1", "iPhone9,3":                  return .iPhone7
        case "iPhone9,2", "iPhone9,4":                  return .iPhone7Plus
        case "iPhone8,4":                               return .iPhoneSE
        case "iPhone10,1", "iPhone10,4":                return .iPhone8
        case "iPhone10,2", "iPhone10,5":                return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                return .iPhoneX
        case "iPhone11,2":                              return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":                return .iPhoneXSMax
        case "iPhone11,8":                              return .iPhoneXR
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return .iPadAir
        case "iPad5,3", "iPad5,4":                      return .iPadAir2
        case "iPad6,11", "iPad6,12":                    return .iPad5
        case "iPad7,5", "iPad7,6":                      return .iPad6
        case "iPad2,5", "iPad2,6", "iPad2,7":           return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return .iPadMini3
        case "iPad5,1", "iPad5,2":                      return .iPadMini4
        case "iPad6,3", "iPad6,4":                      return .iPadPro97Inch
        case "iPad6,7", "iPad6,8":                      return .iPadPro129Inch
        case "iPad7,1", "iPad7,2":                      return .iPadPro129Inch2ndGen
        case "iPad7,3", "iPad7,4":                      return .iPadPro105Inch
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return .iPadPro11Inch
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return .iPadPro129Inch3rdGen
        case "AppleTV5,3":                              return .AppleTV
        case "AppleTV6,2":                              return .AppleTV4K
        case "AudioAccessory1,1":                       return .HomePod
            
        default:                                        return .undefined
        }
    }
    
    var frameRate: Int {
        switch modelName {
        case .undefined:
            return 10
        case .iPodTouch5:
            return 10
        case .iPodTouch6:
            return 10
        case .iPhone4:
            return 10
        case .iPhone4s:
            return 10
        case .iPhone5:
            return 10
        case .iPhone5c:
            return 10
        case .iPhone5s:
            return 10
        case .iPhone6:
            return 10
        case .iPhone6Plus:
            return 10
        case .iPhone6s:
            return 10
        case .iPhone6sPlus:
            return 10
        case .iPhone7:
            return 10
        case .iPhone7Plus:
            return 10
        case .iPhoneSE:
            return 10
        case .iPhone8:
            return 10
        case .iPhone8Plus:
            return 10
        case .iPhoneX:
            return 10
        case .iPhoneXS:
            return 10
        case .iPhoneXSMax:
            return 10
        case .iPhoneXR:
            return 16
        case .iPad2:
            return 10
        case .iPad3:
            return 10
        case .iPad4:
            return 10
        case .iPadAir:
            return 10
        case .iPadAir2:
            return 10
        case .iPad5:
            return 10
        case .iPad6:
            return 10
        case .iPadMini:
            return 10
        case .iPadMini2:
            return 10
        case .iPadMini3:
            return 10
        case .iPadMini4:
            return 10
        case .iPadPro97Inch:
            return 10
        case .iPadPro129Inch:
            return 10
        case .iPadPro129Inch2ndGen:
            return 10
        case .iPadPro105Inch:
            return 10
        case .iPadPro11Inch:
            return 10
        case .iPadPro129Inch3rdGen:
            return 10
        default:
            return 10
        }
    }
    
}
