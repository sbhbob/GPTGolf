//
//  EventDetailView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 5/2/23.
//

import SwiftUI

struct EventDetailView: View {
    
    let event: Event?
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                VStack(spacing: 1) {
                    Text("DESCRIPTION")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                    Text(event?.description ?? "No description found")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                }
                Divider()
                    .editDivideLine(width: 305)
                VStack(spacing: 1) {
                    Text("LOCATION")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                    Text(event?.location ?? "No location found")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                }
                Divider()
                    .editDivideLine(width: 305)
                VStack(spacing: 1) {
                    Text("GOLF GAME")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                    Text(event?.golfGameType ?? "Scramble")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                }
                Divider()
                    .editDivideLine(width: 305)
                VStack {
                    Text("GOLF TEAMS")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                    NavigationLink{
                        Golf_Teams()
                    } label: {
                        HStack {
                            Text("Teams - 18")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top, 10)
                }
                Divider()
                    .editDivideLine(width: 305)
                VStack(spacing: 1) {
                    Text("HOLE - SPONSOR - HOLE MANAGER")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    ScrollView {
                        // MARK: This still needs functionality that updates the hole manager to the cells
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(0..<18, id: \.self) { i in
                                NavigationLink {
                                    if let hole = event?.holes[safe: i] {
                                        EventsTabGameSettingsScreenOneView(hole: hole)
                                    }
                                } label: {
                                    if let hole = event?.holes[safe: i] {
                                        VStack {
                                            HStack {
                                                // change this to the hole manager name later
                                                Text("  \(i + 1) - \(hole.sponsor) - \(hole.holeManagerEmail ?? "Empty Manager")")
                                                    .foregroundColor(.white)
                                                    .background(.clear)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.white)
                                                    .padding(.trailing, 10)
                                            }
                                            .frame(width: 375)
                                            Divider()
                                                .editDivideLine(width: 305)
                                        }
                                    } else {
                                        Text("Error with loading sponsors")
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    .background(Color.primaryColor)
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(Color.primaryColor)
            
            
            GeometryReader { reader in
                Color.navigationColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle(event?.title ?? "Tournament")
        .onAppear {
            if let event {
                if event.UID != "" {
                    print("Setting static eventID to \(String(describing: event.UID))")
                    User.staticEventId = event.UID
                    print("New static eventID \(String(describing: User.staticEventId))")
                }
                
            }
        }
    }
}


struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let event = Event(title: "Muffin Top Tourney",
                          description: "Work off that muffin top with your favorite golf!",
                          location: "Hellfire Fat Camp",
                          isPoker: false,
                          date: Date(),
                          golfGameType: "Scramble",
                          holes: [Hole(ID: "1999",
                                       sponsor: "Mikey TwoNose",
                                       holeNumber: 1,
                                       whoWins: .highScore,
                                       scoringUnit: "Teeth",
                                       gameDescription: "Collect the most teeth!",
                                       isPoker: false)],
                          players: [Player(name: "Tooth Fairy",
                                           teamId: "19999",
                                           holeScores: ["Meat": HoleScore(holeId: "1999",
                                                                          holeNumber: 1,
                                                                          score: 120)],
                                           contestScores: ["Teeth": ContestScore(holeId: "1999",
                                                                                 holeNumber: 1,
                                                                                 score: 420)])])
        EventDetailView(event: event)
    }
}
