//
//  GetAllCharactersResponse.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import Foundation

struct GetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [Character]
}

