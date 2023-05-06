//
//  EventsTabAddViewHoleManagerScreenView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/10/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct EventsTabAddViewHoleManagerScreenView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var emailStr = ""
    @State private var passwordStr = ""
    @State private var companyStr = ""
    
    @Binding var hole: Hole
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 50) {
                Spacer()
                //                    if hole?.holeManagerEmail != nil {
                //                        VStack(spacing: 0) {
                //                            Text("Current Hole Manager's Email")
                //                                .largeText()
                //                                .bold()
                //                            Text("\("This is the username")")
                //                                .largeText()
                //                                .frame(maxWidth: .infinity, alignment: .center)
                //                        }
                //                    }
                VStack(spacing: 30) {
                    Text(/*currentHoleManager != nil ? "Change Hole Manager" : */"Add Hole Manager")
                        .largeText()
                        .frame(maxWidth: .infinity, alignment: .center)
                    VStack(spacing: 10) {
                        TextField("Email", text: $emailStr)
                            .clearTextField(show: emailStr.isEmpty, text: "Email")
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                        Divider()
                            .editDivideLine(width: 250)
                    }
                    VStack(spacing: 10) {
                        TextField("Company Name", text: $companyStr)
                            .clearTextField(show: companyStr.isEmpty, text: "Company Name")
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                        Divider()
                            .editDivideLine(width: 250)
                    }
                    
                    VStack(spacing: 10) {
                        SecureField("Password", text: $passwordStr)
                            .clearTextField(show: passwordStr.isEmpty, text: "Password")
                        Divider()
                            .editDivideLine(width: 250)
                    }
                }
                
                Button(hole.holeManagerEmail != nil ? "Change Account" : "Create Account") {
                    registerHoleManager()
                    dismiss()
                }
                .roundDarkButton()
                Spacer()
                Spacer()
            }
            
        }
        .navigationTitle("Hole Manager - Hole \(hole.holeNumber)")
    }
    
}

extension EventsTabAddViewHoleManagerScreenView {
    func registerHoleManager() {
        Auth.auth().createUser(withEmail: emailStr, password: passwordStr) { result, error in
            if error != nil {
                print("Error with signing up Hole Manager Account")
            } else {
                if let userUID = result?.user.uid {
                    let db = Firestore.firestore()
                    
                    let docRef = db.collection("Users").document(userUID)
                    
                    docRef.setData(["user": userUID, "userType": "holeManager", "email": emailStr, "eventID": User.staticEventId!, "holeID": "\(hole.holeNumber)"]) { error in
                        if error != nil {
                            print("Error writing document: \(docRef)")
                        } else {
                            print("HoleManager: \(userUID) successfully written")
                        }
                    }
                }
            }
        }
    }
}

struct EventsTabAddViewHoleManagerScreenView_Previews: PreviewProvider {
    static var previews: some View {
        EventsTabAddViewHoleManagerScreenView(hole: .constant(Hole(sponsor: "sponsor", holeNumber: 1, whoWins: .highScore, scoringUnit: "points", gameDescription: "Description", isPoker: false)))
    }
}
