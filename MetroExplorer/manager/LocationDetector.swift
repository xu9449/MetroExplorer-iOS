//
//  LocationDetector.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/26/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double)
    func locationNotDetected()
}

class LocationDetector: NSObject {
    var gameTimer: Timer!
    let locationManager = CLLocationManager()
    
    var delegate: LocationDetectorDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func findLocation() {
        
        let permissionStatus = CLLocationManager.authorizationStatus()
        
        switch(permissionStatus) {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            delegate?.locationNotDetected()
        case .denied:
            delegate?.locationNotDetected()
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            gameTimer = Timer.scheduledTimer(timeInterval: 10,target: self, selector: #selector(runTimeCode), userInfo: nil, repeats: true)
            
        }
    }
    
    @objc  func runTimeCode() {
        
        locationManager.stopUpdatingLocation()
        delegate?.locationNotDetected()
        
    }
    
}


extension LocationDetector: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            delegate?.locationDetected(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        delegate?.locationNotDetected()
    }
    
    //this gets called after user accepts OR denies permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            delegate?.locationNotDetected()
        }
    }
    
}

