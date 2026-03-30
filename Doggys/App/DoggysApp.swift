//
//  DoggysApp.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI
import SwiftData

@main
struct DoggysApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: DogModel.self)
    }
}
