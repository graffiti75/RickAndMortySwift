//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by graffiti75 on 17/12/25.
//

import Foundation
internal import Combine

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    
    func loadCharacters(page: Int = 1) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await networkService.fetchCharacters(page: page)
            characters = response.results
        } catch NetworkError.invalidURL {
            errorMessage = "Invalid URL"
        } catch NetworkError.invalidResponse {
            errorMessage = "Invalid server response"
        } catch NetworkError.decodingError {
            errorMessage = "Failed to decode data"
        } catch {
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
