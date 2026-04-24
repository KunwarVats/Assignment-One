//
//  Event.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import Foundation
import SwiftData

struct EventDTO: Codable, Identifiable {
    let id: Int
    let title: String
    let location: String
    let time: String
    let imageUrl: String?
    let latitude: Double?
    let longitude: Double?
}

extension EventDTO {
    
    init(event: Event) {
        self.id = event.id
        self.title = event.title
        self.location = event.location
        self.time = event.time
        self.imageUrl = event.imageURL
        self.latitude = event.latitude
        self.longitude = event.longitude
    }
    
    static func fromEvents(_ events: [Event]) -> [EventDTO] {
        events.map { EventDTO(event: $0) }
    }
}

@Model
final class Event {
    var id: Int
    var title: String
    var location: String
    var time: String
    var imageURL: String?
    var latitude: Double?
    var longitude: Double?
    
    init(
        id: Int,
        title: String,
        location: String,
        time: String,
        imageURL: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = id
        self.title = title
        self.location = location
        self.time = time
        self.imageURL = imageURL
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(dto: EventDTO) {
        self.id = dto.id
        self.title = dto.title
        self.location = dto.location
        self.time = dto.time
        self.imageURL = dto.imageUrl
        self.latitude = dto.latitude
        self.longitude = dto.longitude
    }
    
    static func fromDTOs(_ dtos: [EventDTO]) -> [Event] {
        dtos.map { Event(dto: $0) }
    }
}
