//
//  DogBreed.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI
import CoreData

struct DogBreed: Identifiable {
    let id = UUID()
    let name: String
    let icon: ImageResource
    let color: Color
}
