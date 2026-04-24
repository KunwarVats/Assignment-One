//
//  LocationManager.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import CoreLocation
import SwiftUI

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        self.requestPermission()
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        userLocation = location.coordinate
    }
}
