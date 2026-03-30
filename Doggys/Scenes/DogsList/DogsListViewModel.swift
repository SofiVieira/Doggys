//
//  DogsListViewModel.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import Foundation
import UIKit
import SwiftData

// MARK: - Input protocol
protocol DogsListViewModelInput {
    func setOutput(_ output: DogsListViewModelOutput?)
    
    func getViewTitle() -> String?
    func getDoneButtonTitle() -> String
    func isDoneButtonEnabled() -> Bool
    
    func getDogsList() -> [DogModel]
    func fetchSelectedDogs()
    func updateDogSelectedState(at row: Int, isSelected: Bool)
    func persistSelectedDogs()
}

// MARK: - Output protocol {
protocol DogsListViewModelOutput: AnyObject {
    func setSelectedCells(indexPaths: [IndexPath])
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
    private weak var output: DogsListViewModelOutput?
    
    // MARK: - Dependencies
    private let title: String?
    private let modelContext: ModelContext
    
    // MARK: - Intializer
    init(title: String? = nil, modelContext: ModelContext) {
        self.title = title
        self.modelContext = modelContext
    }
    
    // MARK: - Public methods
    func setOutput(_ output: DogsListViewModelOutput?) {
        self.output = output
    }
    
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
    
    func fetchSelectedDogs() {
        let descriptor: FetchDescriptor<DogModel> = .init()
        let _selectedDogs: [DogModel]? = try? modelContext.fetch(descriptor)
        self.selectedDogs = _selectedDogs ?? []
        
        var indexPathsToUpdate: [IndexPath] = []
        for index in 0..<dogs.count {
            guard selectedDogs.contains(where: { $0.name == dogs[index].name }) else { continue }
            indexPathsToUpdate.append(.init(item: index, section: 0))
        }
        output?.setSelectedCells(indexPaths: indexPathsToUpdate)
    }
    
    func updateDogSelectedState(at row: Int, isSelected: Bool) {
        if isSelected {
            didSelectDog(at: row)
            return
        }
        
        didDeselectDog(at: row)
    }
    
    func persistSelectedDogs() {
        try? modelContext.delete(model: DogModel.self)
        
        selectedDogs.forEach { dog in
            modelContext.insert(dog)
        }
        
        try? modelContext.save()
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
