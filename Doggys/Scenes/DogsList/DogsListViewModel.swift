//
//  DogsListViewModel.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import Foundation
import UIKit

// MARK: - Input protocol
protocol DogsListViewModelInput {
    func getViewTitle() -> String?
    func getDoneButtonTitle() -> String
    func isDoneButtonEnabled() -> Bool
    
    func getDogsList() -> [DogModel]
    func updateDogSelectedState(at row: Int, isSelected: Bool)
}

// MARK: - Concrete implementation
final class DogsListViewModel: DogsListViewModelInput {
    
    // MARK: - Private properties
    private let dogs: [DogModel] = [
        .init(name: "Yorkshire", image: "Yorkshire", colorHex: UIColor.systemYellow.hexString),
        .init(name: "Samoieda", image: "Samoieda", colorHex: UIColor.systemGreen.hexString),
        .init(name: "Cocker Spaniel", image: "CockerSpaniel", colorHex: UIColor.systemBlue.hexString),
        .init(name: "King Cavalier", image: "KingCavalier", colorHex: UIColor.systemPurple.hexString),
        .init(name: "Maltês", image: "Maltes", colorHex: UIColor.systemRed.hexString),
        .init(name: "Shiba Inu", image: "ShibaInu", colorHex: UIColor.systemOrange.hexString),
    ]
    private var selectedDogs: [DogModel] = []
    
    // MARK: - Dependencies
    private let title: String?
    
    // MARK: - Intializer
    init(title: String? = nil) {
        self.title = title
    }
    
    // MARK: - Public methods
    func getViewTitle() -> String? {
        return title
    }
    
    func getDoneButtonTitle() -> String {
        return "Pronto"
    }
    
    func isDoneButtonEnabled() -> Bool {
        return !selectedDogs.isEmpty
    }
    
    func getDogsList() -> [DogModel] {
        return dogs
    }
    
    func updateDogSelectedState(at row: Int, isSelected: Bool) {
        if isSelected {
            didSelectDog(at: row)
            return
        }
        
        didDeselectDog(at: row)
    }
}

// MARK: - Private methods
private extension DogsListViewModel {
    func didSelectDog(at row: Int) {
        selectedDogs.append(dogs[row])
    }
    
    func didDeselectDog(at row: Int) {
        let tappedDog: DogModel = dogs[row]
        selectedDogs.removeAll(where: { $0 == tappedDog })
    }
}
