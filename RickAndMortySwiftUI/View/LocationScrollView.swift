// LocationScrollView.swift
// RickAndMortySwiftUI
//
// Created by Okan Özdemir on 23.04.2023.
//

import SwiftUI

struct LocationScrollView: View {
    let locations: [Location]
    @Binding var selectedLocation: Location?
    let fetchSelectedLocationsCharacters: (Location) -> Void
    let fetchNextPage: () -> Void
    @State private var isLoading = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(locations.indices, id: \.self) { index in
                    let location = locations[index]
                    Button(action: {
                        self.selectedLocation = location
                        fetchSelectedLocationsCharacters(location)
                    }, label: {
                        Text(location.name)
                            .font(.headline)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 12)
                            .foregroundColor(selectedLocation == location ? Color(UIColor.systemBackground) : .blue)
                            .background(selectedLocation == location ? Color.blue : Color(UIColor.secondarySystemBackground))
                            .cornerRadius(20)
                    }).onAppear {
                        if index == locations.count - 1, index != 125 {
                            isLoading = true
                            fetchNextPage()                            
                            if index == 125 {
                                isLoading = false
                            }
                        }
                    }
                }.padding(.horizontal, 5)
                if isLoading {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 5)
                }
            }
            .frame(maxHeight: 30)
            
        }
    }
}
