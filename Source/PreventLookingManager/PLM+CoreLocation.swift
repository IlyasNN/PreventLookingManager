//
//  PLM+CoreLocation.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 07.05.2021.
//

import Foundation
import CoreLocation

extension PreventLookingManager: CLLocationManagerDelegate {
    
    var permissionStatus: Bool {
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            return true
        case .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            if #available(iOS 14.0, *) {
                let accuracyAuthorization = locationManager.accuracyAuthorization
                switch accuracyAuthorization {
                case .fullAccuracy:
                    return true
                case .reducedAccuracy:
                    return false
                @unknown default:
                    return false
                }
            }
            return true
        @unknown default:
            return false
        }
    }
    
    func processLocation(_ current:CLLocation) {
        guard lastLocation != nil else {
            lastLocation = current
            return
        }
        var speed = current.speed
        if (speed > 0) {
            self.currentSpeed = speed
        } else {
            speed = lastLocation!.distance(from: current) / (current.timestamp.timeIntervalSince(lastLocation!.timestamp))
            print(speed)
        }
        lastLocation = current
    }
    
    func checkConfiguration() {
        if !permissionStatus {
            delegate?.gotError(PLMError.sessionNotAuthorized)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            processLocation(location)
        }
    }
    
}
