//
//  ReadFromFireBae.swift
//  Golf Tournament App
//
//  Created by Tyler Radke on 3/22/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct ReadFromFireBase {
    
    static func getPlayersForEvent(eventId: String, completion: @escaping (Result<[Player], Error>) -> Void) {
        let db = Firestore.firestore()
        let eventRef = db.collection("Events").document(eventId)
        
        eventRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let document = document, document.exists {
                    do {
                        if let eventData = document.data(),
                           let playersData = eventData["players"] as? [[String: Any]] {
                            let players = try playersData.map { playerData -> Player in
                                let player = try Firestore.Decoder().decode(Player.self, from: playerData)
                                return player
                            }
                            completion(.success(players))
                        } else {
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid data format"])))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])))
                }
            }
        }
    }
    
    static func getPlayersWithTeamId(teamId: String, completion: @escaping (Result<[Player], Error>) -> Void) {
            let db = Firestore.firestore()
            let playersRef = db.collection("Players")
            
            playersRef.whereField("teamId", isEqualTo: teamId).getDocuments { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    var players: [Player] = []
                    
                    querySnapshot?.documents.forEach { document in
                        if let player = try? document.data(as: Player.self) {
                            players.append(player)
                        }
                    }
                    
                    completion(.success(players))
                }
            }
        }
    
    //MARK: General functions, for both HoleManagers and EventPlanners
    //Function gets currently logged in user as a [String: Any] Dictionary
    static func getCurrentUserData(completion: @escaping (Result<User, Error>) -> Void) {
        let ref = Firestore.firestore()
        let user = Auth.auth().currentUser
        let usersRef = ref.collection("Users")

        guard let uid = user?.uid else {
            completion(.failure(NSError(domain: "User not found", code: 404, userInfo: nil)))
            return
        }

        let userRef = usersRef.document(uid)

        userRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let document = document else {
                completion(.failure(NSError(domain: "Document not found", code: 404, userInfo: nil)))
                return
            }
            do {
                guard let user = try? document.data(as: User.self) else {
                    completion(.failure(NSError(domain: "User decoding error", code: 500, userInfo: nil)))
                    return
                }
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }


    
    //MARK: HoleManager Functions
    //Gets reference to hole associated with a given event/hole id
    static func getManagerHole(eventId: String, holeId: String, completion: @escaping(Hole) -> Void) {
        let ref = Firestore.firestore()
        
        let eventsRef = ref.collection("Events")
        
        let eventRef = eventsRef.document(eventId)
        
        let holesRef = eventRef.collection("Holes")
        
        let holeRef = holesRef.document(holeId)
        
        holeRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot else {
                print("Could not fetch document")
                return
            }
            
            guard snapshot.data() != nil else {
                print("Could not fetch data")
                return
            }
            
            do {
                let hole = try snapshot.data(as: Hole.self)
                completion(hole)
            } catch {
                print("Failure getting manager hole")
            }
        }
    }
    
    /// "Update a given paramater in a hole."
    /// - Parameters:
    ///   - paramater: The paramater of the hole being updated, Eg: gameDescription
    ///   - newParamater: The new value for the paramater
    ///   - hole: The holeId for the hole being updated
    ///   - event: The eventId for the Event which contains the hole
    static func updateHole(_ paramater: String, with newParamater: Any, for hole: String, in event: String) {
        let ref = Firestore.firestore()
        
        let allEventsRef = ref.collection("Events")
        
        let eventRef = allEventsRef.document(event)
        
        let allHolesRef = eventRef.collection("Holes")
        
        let holeRef = allHolesRef.document(hole)
        
        holeRef.updateData([paramater : newParamater])
    }
    
    //MARK: Functions for EventPlanner
    //Gets array of events for currently logged in EventPlanner
    static func getEventsData(for ids: [String], completion: @escaping (([Event]) -> Void)) {
        //[String: Any] dict is an event object until I can get a decoder working
        var eventsArray: [Event] = []
        
        let ref = Firestore.firestore()
        
        let eventsRef = ref.collection("Events")
        
        for id in ids {
            let eventDoc = eventsRef.document(id)

            eventDoc.addSnapshotListener { (snapshot, error) in
                do {
                    if let event = try snapshot?.data(as: Event.self) {
                        eventsArray.append(event)
                        completion(eventsArray)
                    } else {
                        print("event was nil")
                    }
                } catch {
                    print("error with Event listener")
                }
            }
            
            eventDoc.getDocument { snapshot, error in
                if let error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    if let data = snapshot!.data() {
                        for item in data {
                            if item.key == "UID" {
                                if item.value as? String == "" {
                                    eventDoc.updateData(["UID": id])
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
// The reading functions below still need to be tested
// MARK: Function to get an array of Holes for a given eventId:

func getHoles(for eventId: String, completion: @escaping (Result<[Hole], Error>) -> Void) {
    let db = Firestore.firestore()

    db.collection("events").document(eventId).collection("holes").getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            do {
                let holes = try querySnapshot?.documents.compactMap { try $0.data(as: Hole.self) }
                completion(.success(holes ?? []))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

// MARK: Function to get all Players with a given teamId:

func getPlayers(with teamId: String, completion: @escaping (Result<[Player], Error>) -> Void) {
    let db = Firestore.firestore()

    db.collection("players").whereField("teamId", isEqualTo: teamId).getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            do {
                let players = try querySnapshot?.documents.compactMap { try $0.data(as: Player.self) }
                completion(.success(players ?? []))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

// MARK: Function to get ContestScores for a given playerId:

func getContestScores(for playerId: String, completion: @escaping (Result<[ContestScore], Error>) -> Void) {
    let db = Firestore.firestore()

    db.collection("players").document(playerId).collection("contestScores").getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            do {
                let contestScores = try querySnapshot?.documents.compactMap { try $0.data(as: ContestScore.self) }
                completion(.success(contestScores ?? []))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

// MARK: Function to get HoleScores for a given playerId:

func getHoleScores(for playerId: String, completion: @escaping (Result<[HoleScore], Error>) -> Void) {
    let db = Firestore.firestore()

    db.collection("players").document(playerId).collection("holeScores").getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            do {
                let holeScores = try querySnapshot?.documents.compactMap { try $0.data(as: HoleScore.self) }
                completion(.success(holeScores ?? []))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

// MARK: Function to get an array of Players for a given eventId:

func getPlayers(for eventId: String, completion: @escaping (Result<[Player], Error>) -> Void) {
    let db = Firestore.firestore()

    db.collection("events").document(eventId).collection("players").getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            do {
                let players = try querySnapshot?.documents.compactMap { try $0.data(as: Player.self) }
                completion(.success(players ?? []))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

/*
 I used .compactMap to transform the Firestore documents into the corresponding Swift structures while filtering out any documents that failed to be converted. This ensures that the resulting arrays only contain valid objects.

 Using .compactMap in this context aligns with the Firebase documentation you provided earlier, specifically the "Read Data" section, which describes how to retrieve and handle documents from Firestore. Although the documentation doesn't explicitly mention .compactMap, it is a natural choice in this situation due to its ability to both transform and filter the elements.

 Here's a snippet from one of the functions I provided earlier:

 swift
 Copy code
 func getHoles(eventId: String, completion: @escaping (Result<[Hole], Error>) -> Void) {
     db.collection("events").document(eventId).collection("holes").getDocuments { querySnapshot, error in
         if let error = error {
             completion(.failure(error))
         } else {
             let holes = querySnapshot?.documents.compactMap { queryDocumentSnapshot -> Hole? in
                 return try? queryDocumentSnapshot.data(as: Hole.self)
             }
             completion(.success(holes ?? []))
         }
     }
 }
 In this function, I used .compactMap on querySnapshot?.documents to attempt to convert each queryDocumentSnapshot into a Hole object using the line return try? queryDocumentSnapshot.data(as: Hole.self). If the conversion is successful, the Hole object is added to the resulting array. If the conversion fails (i.e., the data doesn't match the expected structure), a nil value is returned, which is then filtered out by .compactMap. This way, we get an array of valid Hole objects, which is passed to the completion handler as .success(holes ?? []).
 */
extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try?
               JSONSerialization.jsonObject(with: self,
               options: []),
            let jsonData = try?
               JSONSerialization.data(withJSONObject:
               jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData,
               encoding: .utf8) else {
                print("Failed to read JSON Object.")
                return
        }
        print(prettyJSONString)
    }
}
