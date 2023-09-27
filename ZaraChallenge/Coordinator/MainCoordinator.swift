//
//  MainCoordinator.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 25/09/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        
        let listViewModel = CharacterListViewModel()
        let characterListVC = CharacterViewController(viewModel: listViewModel)
        characterListVC.coordinator = self
        
        navigationController.pushViewController(characterListVC, animated: true)
    }
    
    func showCharacterDetail(character: Character) {
        let viewModel = CharacterDetailViewModel(character: character)
        let detailVC = CharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(detailVC, animated: true)
    }
}
