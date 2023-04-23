//
//  CharacterDetailViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var episodeNumbers: String {
        let lastComponent = character.episode.compactMap { url -> Int? in
            guard let lastPathComponent = URL(string: url)?.lastPathComponent else { return nil }
            return Int(lastPathComponent)
        }
        let episodeNumber = lastComponent.map { String($0) }.joined(separator: ", ")
        return episodeNumber
    }
    
    func convertedDate() -> String {
        let inputDateString = character.created
        let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let outputDateFormat = "dd MMM yyyy, HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat

        if let inputDate = dateFormatter.date(from: inputDateString) {
            dateFormatter.dateFormat = outputDateFormat
            dateFormatter.locale = Locale(identifier: "en_US")
            let outputDateString = dateFormatter.string(from: inputDate)
            return outputDateString
        } else {
            print("Invalid input date string")
            return "not known"
        }
    }
}
