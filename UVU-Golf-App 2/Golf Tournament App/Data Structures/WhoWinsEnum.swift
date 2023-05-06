//
//  WhoWinsEnum.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/13/23.
//

import Foundation

enum WhoWins: Codable, CaseIterable {
    case highScore, lowScore
    
    enum CodingKeys: String, Codable, CodingKey {
        case highScore = "highScore"
        case lowScore = "lowScore"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            switch value {
            case "highScore":
                self = .highScore
            case "lowScore":
                self = .lowScore
            default:
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Unknown enum case: \(value)"
                )
            }
        } else {
            throw DecodingError.typeMismatch(
                WhoWins.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for WhoWins")
            )
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .highScore:
            try container.encode("highScore")
        case .lowScore:
            try container.encode("lowScore")
        }
    }
}
