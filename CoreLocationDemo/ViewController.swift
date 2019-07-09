//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by Mandeep Singh on 24/04/18.
//  Copyright © 2018 Mandeep Singh. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var userCoords = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetch User Current Location
        self.fetchUserCurrentLocation()
    }
    
    func fetchUserCurrentLocation() {
        
        let locationFetch = LocationManager.SharedManager
        locationFetch.startMonitoring()
        locationFetch.completionBlock = { [weak self] (userCoordinates, errorBlock) in
            
            guard let self = self else { return }
            
            if let isLocationDisabled = errorBlock as? Bool, isLocationDisabled == false {
                print("User Location is Disabled")
                self.showPopIfLocationServiceIsDisable()
                return
            }
            
            if let locationError = errorBlock as? Error {
                print(locationError.localizedDescription)
            }
            
            if let userLocation = userCoordinates as? CLLocationCoordinate2D {
                print(userLocation.latitude, userLocation.longitude)
                self.userCoords = userLocation
            }
        }
    }
    
    private func showPopIfLocationServiceIsDisable() {
        
        let alert = UIAlertController(title: "Access to GPS is restricted", message: "GPS access is restricted. Draw path by location, please enable GPS in the Settings > Privacy > Location Services.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Go to Settings now", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        self.present(alert, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

