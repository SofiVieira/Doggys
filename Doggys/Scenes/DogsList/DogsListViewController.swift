//
//  DogsListViewController.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import UIKit
import SwiftUI

final class DogsListViewController: UIViewController {
    
    // MARK: - Subviews
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: DogListCellView.identifier)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    // MARK: - Private properties
    private var dogsList: [DogModel] {
        viewModel.getDogsList()
    }
    
    // MARK: - Dependencies
    private let viewModel: DogsListViewModelInput
    
    // MARK: - Initializers
    init(viewModel: DogsListViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.getViewTitle()
        setNavigationBarItens()
    }
}

// MARK: - Private methods
private extension DogsListViewController {
    func setNavigationBarItens() {
        let closeBarItem: UIBarButtonItem = .init(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.leftBarButtonItem = closeBarItem
        
        let addBarItem: UIBarButtonItem = UIBarButtonItem(
            title: viewModel.getDoneButtonTitle(),
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        navigationItem.rightBarButtonItem = addBarItem
        updateDoneButtonEnabledState()
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func doneButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func updateDoneButtonEnabledState() {
        navigationItem.rightBarButtonItem?.isEnabled = viewModel.isDoneButtonEnabled()
    }
}

// MARK: - UICollectionViewDataSource
extension DogsListViewController: UICollectionViewDataSource {
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return .init { sectionIndex, _ in
            let itemSize: NSCollectionLayoutSize = .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
            
            let groupSize: NSCollectionLayoutSize = .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(150)
            )
            let group: NSCollectionLayoutGroup = .horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.interItemSpacing = .fixed(16)
            
            let section: NSCollectionLayoutSection = .init(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(
                top: .zero,
                leading: 16,
                bottom: .zero,
                trailing: 16
            )
            return section
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DogListCellView.identifier,
            for: indexPath
        )
        let dog: DogModel = dogsList[indexPath.item]
        
        cell.configurationUpdateHandler = { [weak self] cell, state in
            cell.contentConfiguration = UIHostingConfiguration {
                DogListCellView(dog: dog, isSelected: state.isSelected)
            }
            .margins(.all, .zero)
            
            guard let self else { return }
            viewModel.updateDogSelectedState(at: indexPath.row, isSelected: state.isSelected)
            updateDoneButtonEnabledState()
        }
        return cell
    }
}
