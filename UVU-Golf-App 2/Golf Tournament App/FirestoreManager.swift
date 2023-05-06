//
//  FirestoreManager.swift
//  Golf Tournament App
//
//  Created by Robert Steed on 3/21/23.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    static func readHolesWithListener(from eventId: String, completion: @escaping ([Hole]) -> Void) {
        // Create a reference to your Firebase database
        let ref = Firestore.firestore()
        
        // Getting reference to the events collection
        let eventsRef = ref.collection("events")
        
        // Getting reference to the specific event document
        let eventDoc = eventsRef.document(eventId)
        
        // Getting reference to the holes collection for the specific event
        let holesRef = eventDoc.collection("holes")
        
        holesRef.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("error fetching documents")
                return
            }
            var holes: [Hole] = []
            documents.forEach { QueryDocumentSnapshot in
                do {
                    let hole = try QueryDocumentSnapshot.data(as: Hole.self)
                    holes.append(hole)
                } catch {
                    print("failed to decode hole")
                }
            }
            completion(holes)
        }
    }
    
    static func readPlayersWithListener(from eventId: String, completion: @escaping ([Player]) -> Void) {
        let ref = Firestore.firestore()
        let eventsRef = ref.collection("events")
        let eventDoc = eventsRef.document(eventId)
        let playersRef = eventDoc.collection("players")
        
        playersRef.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("error fetching documents")
                return
            }
            var players: [Player] = []
            documents.forEach { QueryDocumentSnapshot in
                do {
                    let player = try QueryDocumentSnapshot.data(as: Player.self)
                    players.append(player)
                } catch {
                    print("failed to decode player")
                }
            }
            completion(players)
        }
    }
}
