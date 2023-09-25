//
//  Endpoint.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import Foundation

/// Represents unique API endpoint
@frozen enum Endpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
}
