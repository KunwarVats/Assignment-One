//
//  HomeFeedViewModel.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import SwiftData
import SwiftUI
import CoreLocation

@MainActor
@Observable
final class HomeViewModel {
    
    var events: [EventDTO] = []
    
    private let repository: EventRepository
    private let networkService: NetworkService
    private let imageCache: ImageCacheProtocol
    private let locationService: LocationServiceProtocol
    private let mapsService: MapsServiceProtocol
    
    var userLocation: CLLocationCoordinate2D?
    
    init(repository: EventRepositoryManager,
         networkService: NetworkServiceManager,
         imageCache: ImageCacheProtocol,
         locationService: LocationService,
         mapsService: MapsServiceProtocol) {
        self.repository = repository
        self.networkService = networkService
        self.imageCache = imageCache
        self.locationService = locationService
        self.mapsService = mapsService
    }
    
    func getEvents(context: ModelContext) async {
        
        if let eventsDB = loadLocalEvents(context: context), eventsDB.count > 0 {
            self.events = EventDTO.fromEvents(eventsDB)
            return
        }
        do {
            self.events = try await networkService.fetchEvents()
            saveEventsInLocalDb(context: context)
        } catch {
            print("error - \(error)")
        }
    }
    
    func saveEventsInLocalDb(context: ModelContext) {
        
        let dbEvents = Event.fromDTOs(events)
        repository.save(events: dbEvents, context: context)
    }
    
    func loadLocalEvents(context: ModelContext) -> [Event]? {
        do {
            return try repository.fetchAll(context: context)
        } catch {
            print(error)
            return nil
        }
    }
    
    func loadImage(from urlString: String) async -> UIImage? {
        
        if let cached = imageCache.get(for: urlString) {
            return cached
        }
        
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            imageCache.set(image, for: urlString)
            return image
        } catch {
            return nil
        }
    }
    
    func updateLocation(_ location: CLLocationCoordinate2D?) {
        self.userLocation = location
    }
    
    func distance(for event: EventDTO) -> String {
        
        guard let userLocation else { return "Unknown" }
        guard let latitude = event.latitude, let longitude = event.longitude else { return "Unknown" }
        
        if latitude == 0 && longitude == 0 {
            return "Online"
        }
        
        let km = locationService.distance(from: userLocation, to: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)).toKilometers
        
        return String(format: "%.1f km away", km)
    }
    
    func openMaps(event: EventDTO) {
        mapsService.openDirections(to: event)
    }
}
