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
        let listView = CharacterListView(with: listViewModel)
        let characterListVC = CharacterViewController(listView: listView)
        listViewModel.delegate = listView
        listView.delegate = characterListVC
        
        navigationController.pushViewController(characterListVC, animated: true)
    }
}
