//
//  PlayerDataStructure.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/13/23.
//

import FirebaseFirestoreSwift
import Foundation

struct Player: Codable, Identifiable, Equatable {
    var id = UUID()
    @DocumentID var UID: String?
    var name: String
    var teamId: String
    var holeScores: [String: HoleScore]
    var contestScores: [String: ContestScore]
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}
