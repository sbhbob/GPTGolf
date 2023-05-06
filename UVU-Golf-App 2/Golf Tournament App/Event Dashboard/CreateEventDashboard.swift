//
//  CreateEventDashboard.swift
//  Golf Tournament App
//
//  Created by Tyler Radke on 3/14/23.
//


import SwiftUI
import Firebase
import FirebaseAuth

struct CreateEditEvent: View {
    @Environment(\.dismiss) var dismiss

    @State private var eventTitle: String = ""
    @State private var eventLocation: String = ""
    @State private var eventDescription: String = ""
    @State private var showingCreateConfirmation = false
    @State private var golfGameType = "stroke"
    @State private var inEditingMode: Bool = false
    @State private var returnToDashboard = false
    @State private var eventDate: Date = Date.now
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        self.inEditingMode = false
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    

    var body: some View {
            ZStack(alignment: .top) {
                Color.navigationColor
                    .ignoresSafeArea()
                Color.primaryColor
                
                VStack() {
                    VStack(alignment: .leading) {
                        Text("Event Title")
                        TextField("Title", text: $eventTitle)
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(.black)
                        
                        Text("Event Location")
                        TextField("Location (leave blank if unknown)", text: $eventLocation)
                            .textFieldStyle(.roundedBorder)
                            .frame(height: 35)
                            .foregroundColor(.black)
                        
                        Text("Golf Game")
                        Picker(selection: .constant(1), label: Text("Picker")) {
                            Text("Stroke").tag(1)
                            Text("Scramble").tag(2)
                        }
                        
                        .pickerStyle(.segmented)
                        Text("Poker")
                        Picker(selection: .constant(1), label: Text("Picker")) {
                            Text("Enable Poker").tag(1)
                            Text("Disable Poker").tag(2)
                        }
                        .pickerStyle(.segmented)
                        
                        Text("Event Date")
                        DatePicker(selection: $eventDate, displayedComponents: .date, label: { Text("Date")})
                            .datePickerStyle(.compact)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Event Description")
                        TextField("Event Description", text: $eventDescription)
                            .textFieldStyle(.roundedBorder)
                            .padding(.bottom, 75)
                            .foregroundColor(.black)
                    }
                    
                    
                VStack {
                    Button("Create/Save Event") {
                        guard eventTitle != "", eventLocation != "", eventDescription != "" else { return }
                        showingCreateConfirmation = true
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.black)
                    .confirmationDialog("Create Event?", isPresented: $showingCreateConfirmation) {
                        
                        Button((self.inEditingMode ? "Save Changes" : "Create Event"), role: nil) {

                            let defaultHoles = [
                                Hole(sponsor: "Empty Sponsor", holeNumber: 1, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 2, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 3, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 4, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 5, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 6, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 7, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 8, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 9, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 10, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 11, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 12, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 13, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 14, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 15, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 16, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 17, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false),
                                Hole(sponsor: "Empty Sponsor", holeNumber: 18, whoWins: .lowScore, scoringUnit: "points", gameDescription: "Description", isPoker: false)
                            ]
                            
                            let event = Event(ID: "\(UUID())", title: eventTitle, description: eventDescription, location: eventLocation, isPoker: false, date: Date(), golfGameType: "fun", holes: defaultHoles, players: [], UID: "")

                            
                            if let userID = Auth.auth().currentUser?.uid {
                                WriteToFirebase.writeEvent(event: event, to: userID) { result in
                                    switch result {
                                    case .success:
                                        print("Event added successfully")
                                        dismiss()
                                    case .failure(let error):
                                        print("Error adding event: \(error.localizedDescription)")
                                    }
                                }
                            } else {
                                print("No current user found")
                            }
                        }
                        Button("Cancel", role: .cancel) {
                            showingCreateConfirmation = false
                        }
                    }
                    
                }
                
            }
            .padding(32)
            .foregroundColor(.white)
            .navigationTitle("Add/Edit Event")
        }
//        .sheet(isPresented: $returnToDashboard) {
////            AdminEventScreen() this causes it to create  a new eventScreen not go back to old one
//        }
    }
    
}

struct CreateEditEvent_Previews: PreviewProvider {
    static var previews: some View {
        CreateEditEvent()
        
    }
}
