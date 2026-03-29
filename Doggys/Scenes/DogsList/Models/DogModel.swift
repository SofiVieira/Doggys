//
//  DogModel.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import Foundation

struct DogModel: Equatable {
    
    /// Dog Breed name
    let name: String
    let image: String
    let colorHex: String
    
    init(name: String, image: String, colorHex: String) {
        self.name = name
        self.image = image
        self.colorHex = colorHex
    }
}
