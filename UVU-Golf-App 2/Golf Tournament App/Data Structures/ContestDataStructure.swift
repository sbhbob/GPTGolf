//
//  ContestDataStructure.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/13/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct HoleScore: Codable {
    var holeId: String
    var holeNumber: Int
    var score: Int
}

struct ContestScore: Codable {
    var holeId: String
    var holeNumber: Int
    var score: Int
}
