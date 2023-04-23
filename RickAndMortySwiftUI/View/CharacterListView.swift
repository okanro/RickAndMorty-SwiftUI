//
//  CharacterListView.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import SwiftUI

struct CharacterListView: View {
    @Binding var selectedLocation: Location?
    let characters: [Character]
    var body: some View {
        if let selectedLocation = selectedLocation, !selectedLocation.residents.isEmpty {
            List(characters) { character in
                NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))) {
                    CharacterRowView(character: character)
                }.listRowBackground(character.rowColor)
            }
            .listStyle(PlainListStyle())
        } else if selectedLocation != nil {
            List {
                Text("There is no character")
            }
            .listStyle(PlainListStyle())
        } else {
            List(characters) { character in
                NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))) {
                    CharacterRowView(character: character)
                }.listRowBackground(character.rowColor)
            }
            .listStyle(PlainListStyle())
        }    }
}

