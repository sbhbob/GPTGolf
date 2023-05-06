//
//  HoleDataStructure.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/13/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct Hole: Codable, Hashable {
    @DocumentID var ID: String?
    var sponsor: String
    var holeNumber: Int
    var whoWins: WhoWins
    var scoringUnit: String
    var gameDescription: String
    var isPoker: Bool
    var holeManagerEmail: String?
}


