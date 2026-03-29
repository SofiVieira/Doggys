//
//  DogModel.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import Foundation

struct DogModel: Equatable {
    
    let name: String
    let image: String
    
    // TODO: Remove default image value
    init(name: String, image: String = "dog.fill") {
        self.name = name
        self.image = image
    }
}
