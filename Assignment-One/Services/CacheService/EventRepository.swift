//
//  CacheService.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import SwiftData

protocol EventRepository {
    func save(event: Event, context: ModelContext)
    func save(events: [Event], context: ModelContext)
    func fetchAll(context: ModelContext) throws -> [Event]
}

final class EventRepositoryManager: EventRepository {
    
    func save(event: Event, context: ModelContext) {
        context.insert(event)
        try? context.save()
    }
    
    func save(events: [Event], context: ModelContext) {
        for event in events {
            context.insert(event)
        }
        try? context.save()
    }
    
    func fetchAll(context: ModelContext) throws -> [Event] {

        let descriptor = FetchDescriptor<Event>()
        return try context.fetch(descriptor)
    }
}
