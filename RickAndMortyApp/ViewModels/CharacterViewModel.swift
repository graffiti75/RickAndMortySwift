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
    @Published var isLoadingMore: Bool = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var canLoadMore: Bool = true
    
    func loadCharacters() async {
        // Reset for initial load
        currentPage = 1
        isLoading = true
        errorMessage = nil
        characters = []
        
        do {
            let response = try await networkService.fetchCharacters(page: currentPage)
            characters = response.results
            totalPages = response.info.pages
            canLoadMore = currentPage < totalPages
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
    
    func loadMoreCharacters() async {
        // Prevent multiple simultaneous loads
        guard !isLoadingMore && canLoadMore else { return }
        
        isLoadingMore = true
        currentPage += 1
        
        do {
            let response = try await networkService.fetchCharacters(page: currentPage)
            characters.append(contentsOf: response.results)
            totalPages = response.info.pages
            canLoadMore = currentPage < totalPages
        } catch {
            // If error occurs, revert page number
            currentPage -= 1
            print("Error loading more characters: \(error)")
        }
        
        isLoadingMore = false
    }
    
    func shouldLoadMore(currentItem character: Character) -> Bool {
        // Load more when we're near the end (last 5 items)
        guard let index = characters.firstIndex(where: { $0.id == character.id }) else {
            return false
        }
        return index >= characters.count - 5
    }
}
