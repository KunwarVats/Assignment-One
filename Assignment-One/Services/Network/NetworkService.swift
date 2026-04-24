//
//  NetworkService.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import Foundation

protocol NetworkService {
    func fetchEvents() async throws -> [EventDTO]
}

final class NetworkServiceManager: NetworkService {
    
    func fetchEvents() async throws -> [EventDTO] {
        
        guard let url = Bundle.main.url(forResource: Constants.jsonFile, withExtension: Constants.jsonFileExtension) else {
            throw NSError(domain: "MockData not found", code: 404)
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        return try decoder.decode([EventDTO].self, from: data)
    }
}
