//
//  NetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import Foundation
import Alamofire

class NetworkManager: ObservableObject {
    
    let characterURL = URL(string: "https://rickandmortyapi.com/api/character")!
    let locationURL = URL(string: "https://rickandmortyapi.com/api/location")!
    let firstLocationURL = "https://rickandmortyapi.com/api/location/3"
    
    var nextPageURL: URL?

    enum NetworkError: Error {
           case invalidUrl
       }
    
    func fetchCharacters(completion: @escaping ([Character]) -> Void) {
        AF.request(characterURL)
            .responseDecodable(of: APIResponse<Character>.self) { response in
                if let charactersres = response.value {
                    let characters = charactersres.results
                    completion(characters)
                } else {
                    print("error while fetching characters")
                }
            }
    }
    
    func fetchLocations(completion: @escaping ([Location]) -> Void) {
        AF.request(locationURL)
            .responseDecodable(of: APIResponse<Location>.self) { response in
                if let locationResponse = response.value {
                    let locations = locationResponse.results
                    self.nextPageURL = URL(string: locationResponse.info.next ?? self.firstLocationURL)
                    completion(locations)
                } else {
                    print("error location fetch")
                }
            }
    }
    func fetchNextLocationPage(completion: @escaping ([Location]) -> Void) {
        
        AF.request(nextPageURL ?? locationURL).validate().responseDecodable(of: APIResponse<Location>.self) { response in
                if let locationResponse = response.value {
                    let locations = locationResponse.results
                    self.nextPageURL = URL(string: locationResponse.info.next ?? "1")
                    completion(locations)
                } else {
                    print("error next page location fetch")
                }
            }
        }
    func selectedLocationCharacters(selectedLocation: Location ,completion: @escaping ([Character]) -> Void) {
        var characters: [Character] = []
        guard !selectedLocation.residents.isEmpty else {
            print("There is not a character")
            return characters = [] }
        for i in selectedLocation.residents {
            AF.request(i)
                .responseDecodable(of: Character.self) { response in
                    if let charactersres = response.value {
                        characters.append(charactersres)
                        completion(characters)
                    } else {
                        print("error while selected location's characters fetching")
                    }
                }
        }
        
    }

    struct APIResponse<T: Decodable>: Decodable {
        let info: Info
        let results: [T]
    }
    
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
