//
//  LocationService.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import CoreLocation

protocol LocationServiceProtocol {
    func distance(from userLocation: CLLocationCoordinate2D,
                  to eventLocation: CLLocationCoordinate2D) -> Double
}

final class LocationService: LocationServiceProtocol {
    
    func distance(from userLocation: CLLocationCoordinate2D,
                  to eventLocation: CLLocationCoordinate2D) -> Double {
        
        let user = CLLocation(latitude: userLocation.latitude,
                              longitude: userLocation.longitude)
        let event = CLLocation(latitude: eventLocation.latitude,
                               longitude: eventLocation.longitude)
        
        return user.distance(from: event)
    }
}

extension Double {
    var toKilometers: Double {
        self / 1000.0
    }
}
