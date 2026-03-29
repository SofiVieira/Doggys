//
//  DogsListViewModel.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import Foundation

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
        .init(name: "Yorkshire"),
        .init(name: "Samoieda"),
        .init(name: "Cocker Spaniel"),
        .init(name: "King Cavalier"),
        .init(name: "Maltês"),
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
