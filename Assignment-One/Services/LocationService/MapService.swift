//
//  Untitled.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import MapKit

protocol MapsServiceProtocol {
    func openDirections(to event: EventDTO)
}

final class MapsService: MapsServiceProtocol {
    
    func openDirections(to event: EventDTO) {
        
        guard let lat = event.latitude,
              let lon = event.longitude else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let destination = MKMapItem.init(location: CLLocation(latitude: lat, longitude: lon), address: MKAddress(fullAddress: event.location, shortAddress: nil))
        destination.name = event.title
        
        destination.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}
