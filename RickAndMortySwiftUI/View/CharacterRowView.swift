//
//  CharacterRowView.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import SwiftUI

struct CharacterRowView: View {
    let character: Character
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2.0, anchor: .center)
                    .padding()
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                
                Text(character.gender)
                    .font(.subheadline)
                    
            }
        }
    }
}
