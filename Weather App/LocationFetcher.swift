//
//  LocationFecher.swift
//  Weather App
//
//  Created by Akio Ide on 08/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import CoreLocation

public class LocationFetcher:NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var city: String = ""
    
    override init() {
        self.locationManager = CLLocationManager()
        
        super.init()
        self.locationManager.delegate = self
    }
    
    func fetchLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        //let atitude = userLocation.coordinate.latitude
        //let longitude = userLocation.coordinate.longitude
        self.fetchCurrentCity(location: userLocation)
        manager.stopUpdatingLocation()
    }
    
    func fetchCurrentCity(location: CLLocation) {
        var address: String = "somewhere"
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                if pm.locality != nil {
                    address = pm.locality!
                    self.city = address
                    print(address)
                }
            }
        })
        
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + (error.localizedDescription))
    }
}
