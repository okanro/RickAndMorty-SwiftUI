//
//  ContentView.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var selectedLocation: Location?
    @State var isSelectedChanged = false
    @State var isFetched = false
    
    var body: some View {
        NavigationView {
            VStack {
                LocationScrollView(locations: viewModel.locations, selectedLocation: $selectedLocation, fetchSelectedLocationsCharacters: { location in
                                    viewModel.fetchSelectedLocationsCharactersFromNetworkManager(selectedLocation: location)
                }, fetchNextPage: viewModel.fetchNextPage)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    if !isFetched {
                        viewModel.fetchData()
                        isFetched.toggle()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("RMLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                }
                CharacterListView(selectedLocation: $selectedLocation, characters: viewModel.characters)
            }
        }
    }
}
