//
//  DogsListView.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import SwiftUI

struct DogsListView: UIViewControllerRepresentable {
    
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - Dependencies
    private let title: String?
    
    init(title: String? = nil) {
        self.title = title
    }
    
    // MARK: - ViewController type
    typealias UIViewControllerType = DogsListNavigationController
    
    // MARK: - UIViewControllerRepresentable methods
    func makeUIViewController(context: Context) -> DogsListNavigationController {
        let dogsListViewModel: DogsListViewModel = .init(title: title, modelContext: modelContext)
        let dogsListViewController: DogsListViewController = .init(viewModel: dogsListViewModel)
        return DogsListNavigationController(viewController: dogsListViewController)
    }
    
    func updateUIViewController(_ uiViewController: DogsListNavigationController, context: Context) {}
}

// MARK: - UINavigationController wrapper
final class DogsListNavigationController: UINavigationController {
    
    init(viewController: DogsListViewController) {
        super.init(rootViewController: viewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    DogsListView()
}
