//
//  EventDataStructure.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/14/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct Event: Codable, Equatable, Hashable {
    @DocumentID var ID: String?
    var title: String
    var description: String
    var location: String
    var isPoker: Bool
    var date: Date
    var golfGameType: String
    var holes: [Hole]
    var players: [Player]
    var UID: String?
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.ID == rhs.ID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ID)
        hasher.combine(title)
    }
}
