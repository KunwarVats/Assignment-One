//
//  ContentView.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import SwiftUI
import SwiftData
import CoreLocation
import MapKit

struct HomeFeed: View {
    @Environment(\.modelContext) private var context
    @State private var locationManager = LocationManager()
    
    @State private var viewModel = HomeViewModel(
        repository: EventRepositoryManager(),
        networkService: NetworkServiceManager(),
        imageCache: ImageCache(),
        locationService: LocationService(),
        mapsService: MapsService()
    )
    
    var body: some View {
        List {
            ForEach(viewModel.events) { event in
                AsyncImageView(
                    event: event,
                    loader: viewModel
                )
            }
        }
        .onChange(of: locationManager.userLocation?.latitude) { _, _ in
            viewModel.userLocation = locationManager.userLocation
        }
        .task {
            await viewModel.getEvents(context: context)
        }
    }
}

#Preview {
    HomeFeed()
        .modelContainer(for: Event.self, inMemory: true)
}

struct AsyncImageView: View {
    
    let event: EventDTO
    let loader: HomeViewModel
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        EventRowView(event: event, image: image, distance: loader.distance(for: event), onDirectionsTap: {
            loader.openMaps(event: event)
        })
        .task {
            image = await loader.loadImage(from: event.imageUrl ?? "")
        }
    }
}

struct EventRowView: View {
    
    let event: EventDTO
    let image: UIImage?
    let distance: String
    let onDirectionsTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(uiImage: image ?? UIImage(systemName: "photo")!)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                Text(event.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(event.time)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(distance)
                    .font(.caption2)
                    .foregroundColor(.blue)
                Button("Get Directions") {
                    onDirectionsTap()
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
        }
    }
}
