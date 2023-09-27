//
//  CharacterDetailViewModel.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 25/09/23.
//

import UIKit

/// VIew for single character info
final class CharacterDetailView: UIView {

    // MARK: - Atributes
    private let viewModel: CharacterDetailViewModel

    // MARK: - Outlets
    private var collectionView: UICollectionView?
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    // MARK: - Init
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpView() {
        applyViewCode()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }

    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CharacterPhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterPhotoCollectionViewCell.cellIdentifer)
        collectionView.register(CharacterInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.cellIdentifer)
        collectionView.register(CharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterEpisodeCollectionViewCell.cellIdentifer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex]  {
        case .photo:
            let isPortrait = (bounds.width < bounds.height)
            return viewModel.createPhotoSectionLayout(isPortrait: isPortrait)
        case .information:
            return viewModel.createInfoSectionLayout()
        case .episodes:
            return viewModel.createEpisodeSectionLayout()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        collectionView?.collectionViewLayout.invalidateLayout()
    }

}

extension CharacterDetailView: ViewCodeConfiguration {
    // MARK: - Configuration
    func buildHierarchy() {
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
    }
    
    func setupConstraints() {
        guard let collectionView = collectionView else {
            return
        }
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
        backgroundColor = .systemBackground
    }

}

extension CharacterDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterPhotoCollectionViewCell.cellIdentifer,
                for: indexPath
            ) as? CharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterInfoCollectionViewCell.cellIdentifer,
                for: indexPath
            ) as? CharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterEpisodeCollectionViewCell.cellIdentifer,
                for: indexPath
            ) as? CharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
}
