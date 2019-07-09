//
//  File.swift
//  Sugo
//
//  Created by Mandeep Singh on 24/04/18.
//  Copyright © 2018 Mandeep Singh. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

struct CompletionBlocks {
    
    typealias closure = (_ returnObject: AnyObject?, _ locationEnabled: AnyObject?) -> ()
}

class LocationManager : NSObject {
    
    static let SharedManager = LocationManager()
    
    //Step - 1: Initialize ClLocation Mananger
    var locationManager : CLLocationManager!
    
    //Step - 2: Declare Variables
    private var userCurrentLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var completionBlock : CompletionBlocks.closure?
    
    //Step - 3: Create functions for Location Manager
    private override init() {
        super.init()

        locationManager = CLLocationManager()
    }
    
    func startMonitoring() {
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            self.startUpdatingLocation()
        } else {
            guard let cB = self.completionBlock else { return }
            cB(nil, false as AnyObject)
        }
    }
    
    private func startUpdatingLocation() {
        DispatchQueue.main.async(execute: {
            self.locationManager.startUpdatingLocation()
        })
    }
    
    private func stopUpdatingLocation() {
        DispatchQueue.main.async(execute: {
            self.locationManager.stopUpdatingLocation()
        })
    }
}

extension LocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        guard let cB = self.completionBlock else { return }
        cB(nil, error as AnyObject)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            
            let newCoordinate = manager.location!.coordinate
            
            if userCurrentLocation.latitude != newCoordinate.latitude && userCurrentLocation.longitude != newCoordinate.longitude {
                userCurrentLocation = manager.location!.coordinate
                guard let cB = self.completionBlock else { return }
                cB(userCurrentLocation as AnyObject, nil)
            }
            
            self.stopUpdatingLocation()
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            guard let cB = self.completionBlock else { return }
            cB(nil, false as AnyObject)
        case .authorizedWhenInUse:
            self.startUpdatingLocation()
        case .notDetermined:
            self.startUpdatingLocation()
        default:
            self.startUpdatingLocation()
        }
    }
    
}
