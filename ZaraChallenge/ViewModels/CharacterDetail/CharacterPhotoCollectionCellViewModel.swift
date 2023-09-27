//
//  CharacterPhotoCollectionCellViewModel.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 25/09/23.
//

import Foundation

final class CharacterPhotoCollectionCellViewModel {
    private let imageUrl: URL?

    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }

    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
