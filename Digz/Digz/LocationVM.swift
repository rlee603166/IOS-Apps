//
//  LocationMgr.swift
//
//  Created by Arthur Roolfs on 11/1/23.
//

import Foundation
import CoreLocation


class LocationVM: NSObject, ObservableObject {
    
    private let lm: CLLocationManager
    
    @Published var location: CLLocation?
    @Published var authStatus: CLAuthorizationStatus
    @Published var enabled = false
    
    @Published var restrictedAlertPresenting = false
    @Published var deniedAlertPresenting = false

    override init() {
        lm = CLLocationManager()
        authStatus = lm.authorizationStatus
        
        super.init()
        
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.distanceFilter = 10
        lm.delegate = self
    }
    
    // MARK: ui
    func start() {
        lm.requestWhenInUseAuthorization()
        enabled = true
        lm.startUpdatingLocation()
    }
    
    func stop() {
        lm.stopUpdatingLocation()
        enabled = false
        location = nil
    }
}

extension LocationVM: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authStatus = manager.authorizationStatus
        switch authStatus {
        case .authorizedWhenInUse:
            break
            
        case .restricted:
            restrictedAlertPresenting = true
            
        case .denied:
            deniedAlertPresenting = true
            
        case .notDetermined:
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            location = loc
        }
    }
}
