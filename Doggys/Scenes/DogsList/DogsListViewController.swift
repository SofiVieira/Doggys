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
    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DogListCellView.identifier)
        tableView.backgroundColor = .systemBackground
        return tableView
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
        view = tableView
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

// MARK: - UITableViewDataSource
extension DogsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: DogListCellView.identifier,
            for: indexPath
        )
        let dog: DogModel = dogsList[indexPath.row]
        
        cell.separatorInset = tableView.layoutMargins
        cell.selectionStyle = .none
        cell.configurationUpdateHandler = { [weak self] cell, state in
            cell.contentConfiguration = UIHostingConfiguration {
                DogListCellView(dog: dog, isSelected: state.isSelected)
            }
            
            guard let self else { return }
            viewModel.updateDogSelectedState(at: indexPath.row, isSelected: state.isSelected)
            updateDoneButtonEnabledState()
        }
        return cell
    }
}
