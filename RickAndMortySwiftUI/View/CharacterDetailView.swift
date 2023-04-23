//
//  CharacterDetailView.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack() {
                AsyncImage(url: URL(string: viewModel.character.image))
                    .frame(width: 275, height: 275)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 20)
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Status: ")
                        Text("Species: ")
                        Text("Gender: ")
                        Text("Origin: ")
                        Text("Location: ")
                        Text("Episodes: ")
                        Text("Created at: ").padding(.bottom, 20)
                    }.fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("\(viewModel.character.status)")
                        Text("\(viewModel.character.species)")
                        Text("\(viewModel.character.gender)")
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("\(viewModel.character.origin.name)")
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("\(viewModel.character.location.name)")
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("\(viewModel.episodeNumbers)")
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("\(viewModel.convertedDate())").padding(.bottom, 20)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .font(.custom("Avenir", fixedSize: 22))
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .navigationTitle(viewModel.character.name)
    }
}


struct detailView_Previews: PreviewProvider {
    
    static var previews: some View {
        CharacterDetailView(viewModel: CharacterDetailViewModel(character: Character(id: 1,
                                                                                     name: "Rick Sanchez",
                                                                                     status: "Alive",
                                                                                     species: "Human",
                                                                                     type: "",
                                                                                     gender: "Male",
                                                                                     origin: Character.Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                                                                                     location: Character.Location(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                                                                                     image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                                                                     episode: ["https://rickandmortyapi.com/api/location/1"],
                                                                                     created: "on that time")))
    }
}
