//
//  Character.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: Origin
    let location: SingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
