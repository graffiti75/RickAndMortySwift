//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by graffiti75 on 17/12/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
}

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchCharacters(page: Int = 1) async throws -> CharacterResponse {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
            return characterResponse
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }
}
