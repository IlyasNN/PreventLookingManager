//
//  PLM+CoreLocation.swift
//  PreventLookingScreen
//
//  Created by Илья Соловьёв on 07.05.2021.
//

import Foundation
import CoreLocation

extension PreventLookingManager: CLLocationManagerDelegate {

    func processLocation(_ current:CLLocation) {
        guard lastLocation != nil else {
            lastLocation = current
            return
        }
        var speed = current.speed
        if (speed > 0) {
            self.currentSpeed = speed // or whatever
        } else {
            speed = lastLocation!.distance(from: current) / (current.timestamp.timeIntervalSince(lastLocation!.timestamp))
            print(speed)
        }
        lastLocation = current
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                for location in locations {
                    processLocation(location)
                }
    }
    
}
