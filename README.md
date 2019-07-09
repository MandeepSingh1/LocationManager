# CLLocationManager Singleton in Swift4

This is basically for fetching user current location, In this example Singleton class use for share location service in swift4. This class will auto update location when user change current location using Completion Blocks with error handlling as well.

# Installation
  Drop in the Classes folder to your Xcode project.
  You can also use CocoaPods or Carthage.
  
# Using CocoaPods
  First be sure to run pod repo update to get the latest version available.
  Add pod 'CoreLocationDemo' to your Podfile and run pod install. Also add use_frameworks! to the Podfile.
  
  * target 'MyApp'
  * pod 'CoreLocationDemo', '~> 0.3'
  * use_frameworks!
  
  https://cocoapods.org/pods/CoreLocationDemo

# Updated for Swift 4
  Swift 4 Version
  
# Requirements
  * Version 9.2 or higher
  * Apple LLVM compiler
  * iOS 8.0 or higher
  * ARC
  
# Installation
  * Copy LocationService.swift to your project 
  * add the key "NSLocationAlwaysUsageDescription" to a property list(Info.plist) and set its value to some message what you want. etc. "We requires access to your phone's location bla bla bla :P"
or 
  * add the key "NSLocationWhenInUseUsageDescription" if you want to access the user's location normally while running in the foreground.

# How to use - FetchLocation Class
  * Just use the function which am using in the ViewController Class:- self.fetchUserCurrentLocation(). You have to use this function in your viewController or any other class. You will get the current location of that particular location.

# How to use - Get real time location by Completion Block
  * Just call the below function in your ViewController Class
   
   
   
   import CoreLocation
   
   class ViewController: UIViewController {
    
    var userCoords = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetch User Current Location
        self.fetchUserCurrentLocation()
    }
    
    func fetchUserCurrentLocation() {
        
        let locationFetch = FetchLocation.SharedManager
        locationFetch.parentObject = self
        locationFetch.startUpdatingLocation()
        locationFetch.completionBlock = { [unowned self] (userCoordinates, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            
            if let userLocation = userCoordinates as? CLLocationCoordinate2D {
                print(userLocation.latitude, userLocation.longitude)
                self.userCoords = userLocation
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  }
  
 # Contact Me
    Mandeep Singh
  * Email-ID:- mandeep.singh671@gmail.com
