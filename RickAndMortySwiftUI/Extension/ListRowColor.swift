//
//  ListRowColor.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import Foundation
import SwiftUI

extension Character {
    var rowColor: Color {
        if gender == "Male" {
            return Color.blue.opacity(0.3)
        } else if gender == "Female" {
            return Color.red.opacity(0.3)
        } else {
            return Color.green.opacity(0.3)
        }
    }
}
