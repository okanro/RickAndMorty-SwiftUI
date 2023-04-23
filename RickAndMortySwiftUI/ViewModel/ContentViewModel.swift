//
//  ContentViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var locations: [Location] = []
    @Published var isLoading = false

    private let networkManager = NetworkManager()
    
    func fetchData() {
        fetchCharactersFromNetworkManager()
        fetchLocationsFromNetworkManager()
    }
    
    func fetchCharactersFromNetworkManager() {
        networkManager.fetchCharacters { [weak self] characters in
            self?.characters = characters
        }
    }
    
    func fetchLocationsFromNetworkManager() {
        networkManager.fetchLocations { [weak self] locations in
            self?.locations = locations
        }
    }
    
    func fetchNextPage() {
        networkManager.fetchNextLocationPage { [weak self] locations in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.locations.append(contentsOf: locations)
                self?.isLoading = false
            }
        }
    }
    
    func fetchSelectedLocationsCharactersFromNetworkManager(selectedLocation: Location) {
        networkManager.selectedLocationCharacters(selectedLocation: selectedLocation) { [weak self] characters in
            self?.characters = characters
        }
    }
    
    func characters(for location: Location) -> [Character] {
        return characters.filter { location.residents.contains($0.location.url) }
    }
}
