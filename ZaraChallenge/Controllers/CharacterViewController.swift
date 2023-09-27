//
//  CharacterViewController.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import UIKit


/// Controller to show and search for Characters
final class CharacterViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    private var characterListView: CharacterListView?
    
    convenience init(viewModel: CharacterListViewModel) {
        self.init()
        characterListView = CharacterListView(with: viewModel)
    }
    
    override func loadView() {
        view = characterListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultViewSettings()
        addSearchButton()
        characterListView?.delegate = self
    }
    
    func defaultViewSettings() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        title = "Characters"
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }

    private func addSearchButton() {
        let filterSymbol = UIImage(systemName: "line.horizontal.3.decrease.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterSymbol, style: .plain, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }

}

extension CharacterViewController: CharacterListViewDelegate {
    // MARK: - CharacterListViewDelegate
    func characterListView(_ characterListView: CharacterListView, didSelectCharacter character: Character) {
        coordinator?.showCharacterDetail(character: character)
    }
}

