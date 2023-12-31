//
//  CharacterCollectionViewCellViewModel.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import Foundation

final class CharacterCollectionCellViewModel: Hashable, Equatable {
    public let characterName: String
    private let characterStatus: CharacterStatus
    private let characterImageUrl: URL?

    // MARK: - Init
    init(
        characterName: String,
        characterStatus: CharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }

    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }

    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }

    // MARK: - Hashable
    static func == (lhs: CharacterCollectionCellViewModel, rhs: CharacterCollectionCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}

