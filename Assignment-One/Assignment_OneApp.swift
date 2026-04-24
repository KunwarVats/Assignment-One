//
//  Assignment_OneApp.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import SwiftUI
import SwiftData

@main
struct Assignment_OneApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Event.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeFeed()
        }
        .modelContainer(sharedModelContainer)
    }
}
