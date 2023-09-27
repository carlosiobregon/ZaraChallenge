//
//  CharacterInfoCollectionCellViewModel.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 25/09/23.
//

import UIKit

final class CharacterInfoCollectionCellViewModel {
    private let type: `Type`
    private let value: String

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()

    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()

    public var title: String {
        type.displayTitle
    }

    public var displayValue: String {
        if value.isEmpty { return "None" }

        if let date = Self.dateFormatter.date(from: value),
           type == .created {
            return Self.shortDateFormatter.string(from: date)
        }

        return value
    }

    public var iconImage: UIImage? {
        return type.iconImage
    }

    public var tintColor: UIColor {
        return type.tintColor
    }

    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount

        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemPink
            case .location:
                return .systemYellow
            case .episodeCount:
                return .systemMint
            }
        }

        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "arrowshape.turn.up.right")
            case .gender:
                return UIImage(systemName: "arrowshape.turn.up.right")
            case .type:
                return UIImage(systemName: "arrowshape.turn.up.right")
            case .species:
                return UIImage(systemName: "arrowshape.turn.up.right")
            case .origin:
                return UIImage(systemName: "arrowshape.turn.up.right")
            case .created:
                return UIImage(systemName: "arrowshape.turn.up.right")
            case .location:
                return UIImage(systemName: "arrowshape.turn.up.right")
            case .episodeCount:
                return UIImage(systemName: "arrowshape.turn.up.right")
            }
        }

        var displayTitle: String {
            switch self {
            case .status,
                .gender,
                .type,
                .species,
                .origin,
                .created,
                .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }

    init(type: `Type`, value: String) {
        self.value = value
        self.type = type
    }
}

