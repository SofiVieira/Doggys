//
//  HomeView.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Query var selectedDogs: [DogModel]
    
    var body: some View {
        VStack {
            BreedRouletteView(dogs: selectedDogs)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
