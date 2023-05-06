//
//  UserStruct.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 4/25/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var UID: String?
    var userType: UserType
    var eventId: String? // for hole managers
    var holeId: String? // for hole managers
    var eventIds: [String]? // for event planners
    static var staticEventId: String?
    static var staticHoleId: String?
}

enum UserType: String, Codable {
    case holeManager
    case eventPlanner
}
