//
//  CharacterListView.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import UIKit

protocol CharacterListViewDelegate: AnyObject {
    func characterListView(_ characterListView: CharacterListView,
                           didSelectCharacter character: Character)
}

/// View that handles showing list of characters, loader, etc.
final class CharacterListView: UIView {
    
    // MARK: - Atributes
    private var viewModel: CharacterListViewModel?
    public weak var delegate: CharacterListViewDelegate?
    
    
    // MARK: - Outlets
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier)
        collectionView.register(FooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    init(with viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUpView()
        fetchCharacters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpView() {
        applyViewCode()
        setUpViewModel()
        setUpCollectionView()
    }
    
    private func setUpViewModel() {
        viewModel?.delegate = self
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func fetchCharacters() {
        viewModel?.fetchCharacters()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension CharacterListView: ViewCodeConfiguration {
    // MARK: - Configuration
    func buildHierarchy() {
        addSubviews(collectionView, spinner)
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = true
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureViews() {
        spinner.startAnimating()
    }
    
    
    
}

extension CharacterListView: CharacterListViewModelDelegate {
    // MARK: - CharacterListViewViewModelDelegate
    func didSelectCharacter(_ character: Character) {
        delegate?.characterListView(self, didSelectCharacter: character)
    }
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        self.collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
}
