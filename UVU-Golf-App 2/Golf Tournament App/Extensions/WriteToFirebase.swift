//
//  WriteToFirebase.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/22/23.
//
import Firebase
import FirebaseCore
import FirebaseFirestore
import Foundation

class WriteToFirebase {
    let db = Firestore.firestore()
    
    func addUser(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection("users").document(user.UID ?? "").setData(from: user) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func addEvent(event: Event, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("events").addDocument(from: event) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func addHole(eventId: String, hole: Hole, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("events").document(eventId).collection("holes").addDocument(from: hole) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func addPlayer(eventId: String, player: Player, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("Events").document(eventId).collection("Players").addDocument(from: player) { error in // made both strings captialized
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func addHoleScore(playerId: String, holeScore: HoleScore, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("players").document(playerId).collection("holeScores").addDocument(from: holeScore) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func addContestScore(playerId: String, contestScore: ContestScore, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("players").document(playerId).collection("contestScores").addDocument(from: contestScore) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    static func writeEvent(event: Event, to userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        
        do {
            let documentRef = try db.collection("Events").addDocument(from: event)
            let userRef = db.collection("Users").document(userID)
            userRef.getDocument { document, error in
                if let document = document, document.exists {
                    userRef.updateData(["eventIds": FieldValue.arrayUnion([documentRef.documentID])]) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                } else {
                    userRef.setData(["eventIds": [documentRef.documentID]]) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                }
            }

        } catch let error {
            completion(.failure(error))
        }
    }
}

//These are extra from the merge. Not toally sure why they all doubled, so I'm leaving them there just in case. - Tyler
//func addEvent(event: Event, completion: @escaping (Result<Void, Error>) -> Void) {
//    do {
//       _ = try db.collection("Events").addDocument(from: event)
//        let ref = db.collection("Users")
//
//        let userRef = ref.document(Auth.auth().currentUser?.uid ?? "00000")
//
//        let userDoc = userRef.getDocument { (snapshot, error) in
//
//        }
//
//
//    } catch {
//        print("Error adding to collection")
//    }
//}
//
//func addHole(eventId: String, hole: Hole, completion: @escaping (Result<Void, Error>) -> Void) {
//    do {
//        _ = try db.collection("Events").document(eventId).collection("holes").addDocument(from: hole) { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    } catch let error {
//        completion(.failure(error))
//    }
//}
//
//func addPlayer(eventId: String, player: Player, completion: @escaping (Result<Void, Error>) -> Void) {
//    do {
//        _ = try db.collection("Events").document(eventId).collection("players").addDocument(from: player) { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    } catch let error {
//        completion(.failure(error))
//    }
//}
//
//func addHoleScore(playerId: String, holeScore: HoleScore, completion: @escaping (Result<Void, Error>) -> Void) {
//    do {
//        _ = try db.collection("players").document(playerId).collection("holeScores").addDocument(from: holeScore) { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    } catch let error {
//        completion(.failure(error))
//    }
//}
//
//func addContestScore(playerId: String, contestScore: ContestScore, completion: @escaping (Result<Void, Error>) -> Void) {
//    do {
//        _ = try db.collection("players").document(playerId).collection("contestScores").addDocument(from: contestScore) { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    } catch let error {
//        completion(.failure(error))
//    }
//}
// MARK: How to Call the Functions

//Now you can use these functions to add data to the Firestore:

//let user = User(userType: "hole manager", eventId: "event1", holdId: "hole1", eventIds: nil)
//addUserData(userId: "user1", user: user) { error in
//    if let error = error {
//        print("Error adding user data: \(error)")
//    } else {
//        print("User data added successfully")
//    }
//}

// MARK: Completion Closure Explained

//escaping: When you see a completion handler with @escaping, it means that the closure can "escape" the function it is passed to. In other words, the closure can be stored or passed around to be called later. This is used when you have asynchronous functions, as the function can return before the completion handler is called.

//In Swift, completion handlers are used to perform actions after an asynchronous task has completed. They are commonly used in network requests, database operations, and other tasks that might take some time to execute. The completion handler is essentially a function that you pass as an argument to another function, and it will be called when the task is completed.
//
//In the case of the addEventData and addPlayerData functions, the completion handler has the following type:
//

//(Result<Void, Error>) -> Void
//This means that the completion handler is a function that takes one parameter of type Result<Void, Error> and returns nothing (Void).
//
//Result is an enum in Swift that has two cases: .success and .failure. It's used to represent the outcome of a task:
//
//.success: The task completed successfully. In our case, the associated value is of type Void, which means it doesn't carry any additional information (since we don't need to return anything when the task is successful).
//.failure: The task failed, and the associated value is an Error that provides more information about what went wrong.

//When you call the addEventData or addPlayerData function, you pass a completion handler that will be called when the task finishes, either successfully or with an error. Here's an example of how you would call the addPlayerData function and handle the completion:
//
//let player = Player(name: "John Doe", teamId: "12345", holeScores: [:], contestScores: [:])
//
//addPlayerData(player: player) { result in
//    switch result {
//    case .success():
//        print("Player data was added successfully")
//    case .failure(let error):
//        print("Error adding player data: \(error)")
//    }
//}
//In this example, the completion handler is a closure that takes a result parameter, and it uses a switch statement to handle the success and failure cases. If the data was added successfully, it prints a success message; if there was an error, it prints the error message.


// MARK: In Rsponse to the Warnings/Underscores:

//The warning you're seeing is because the result of the addDocument(from:encoder:completion:) function is not being used in the code. However, in the provided code, we're using the completion handler to return the result of the operation to the caller, so the warning can be safely ignored.
//
//If you want to suppress the warning, you can assign the result of the function call to an underscore:
//
//func addEvent(event: Event, completion: @escaping (Result<Void, Error>) -> Void) {
//    do {
//        _ = try db.collection("events").addDocument(from: event) { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    } catch let error {
//        completion(.failure(error))
//    }
//}
//Do this for all the other functions where you see the warning, and it should go away. The functionality of the code remains the same.
