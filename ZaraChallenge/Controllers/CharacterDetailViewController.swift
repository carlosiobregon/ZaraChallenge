//
//  CharacterDetailViewController.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 25/09/23.
//

import UIKit

/// Controller to show info about single character
final class CharacterDetailViewController: UIViewController {
    
    private var detailView: CharacterDetailView?
    
    // MARK: - Init
    convenience init(viewModel: CharacterDetailViewModel) {
        self.init()
        detailView = CharacterDetailView(viewModel: viewModel)
        title = viewModel.title
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

}

