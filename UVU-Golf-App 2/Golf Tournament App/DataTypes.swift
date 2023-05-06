//
//  File.swift
//  Golf Tournament App
//
//  Created by Robert Steed on 3/7/23.
//

import Foundation

struct Team: Identifiable {
    var id = UUID()
    var teamName: String
    var players: [Player]
}

struct Player: Identifiable {
    var id = UUID()
    var name: String
    var golfScore: Int
    var contestScores: [Int:Int]
}


//    static func <(lhs: Player, rhs: Player) -> Bool {
//        lhs.golfScore > rhs.golfScore
//    }
//}

struct Contest: Identifiable, Hashable {
    var id = UUID()
    var sponserName: String
}

struct HoleManager {
    var hole: Int
    var userName: String
    var Uid = UUID()
    
}

struct Hole {
    var sponser: String
    var number: Int
    var holeManagerId = UUID()
    var contest: Contest
}

struct EventPlanner {
    var eventID = UUID()
    var username: String
    var UID = UUID()
    var sponser: String
}



