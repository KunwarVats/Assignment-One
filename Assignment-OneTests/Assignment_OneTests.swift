//
//  Assignment_OneTests.swift
//  Assignment-OneTests
//
//  Created by Kunwar Vats on 23/04/26.
//

import Testing
import CoreLocation
import UIKit
@testable import Assignment_One

struct Assignment_OneTests {
    
    @Test
    func event_dto_maps_to_event_correctly() async throws {
        
        let dto = EventDTO(
            id: 1,
            title: "Test Event",
            location: "Toronto",
            time: "2026-05-10",
            imageUrl: "https://test.com/image.png",
            latitude: 43.0,
            longitude: -79.0
        )
        
        let event = Event(dto: dto)
        #expect(event.id == dto.id)
        #expect(event.title == dto.title)
        #expect(event.location == dto.location)
        #expect(event.latitude == dto.latitude)
        #expect(event.longitude == dto.longitude)
    }
    
    @Test
    func distance_is_calculated_correctly() {
        
        let service = LocationService()
        let user = CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832)
        let event = CLLocationCoordinate2D(latitude: 43.5890, longitude: -79.6441)
        let distance = service.distance(from: user, to: event)
        #expect(distance > 0)
    }
    
    @Test
    func image_cache_stores_and_returns_image() {
        
        let cache = ImageCache()
        let key = "test-key"
        let image = UIImage(systemName: "photo")!
        cache.set(image, for: key)
        let result = cache.get(for: key)
        #expect(result != nil)
        #expect(result == image)
    }
}

