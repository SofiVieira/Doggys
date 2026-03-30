//
//  DogModel.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import SwiftData

@Model
class DogModel {
    
    /// Dog Breed name
    @Attribute(.unique)
    var name: String
    var image: String
    var colorHex: String
    
    init(name: String, image: String, colorHex: String) {
        self.name = name
        self.image = image
        self.colorHex = colorHex
    }
}
