//
//  EventPlannerPresentTeams.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 5/5/23.
//

import SwiftUI

struct EventPlannerPresentPlayers: View {
    var eventId: String
    var holeId: String

    @State private var players: [Player] = []
    @State private var searchText = ""

    private var filteredPlayers: [Player] {
        players.filter { player in
            searchText.isEmpty || player.name.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Team Leader, Organization", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                ScrollView {
                    LazyVStack {
                        ForEach(filteredPlayers) { player in
                            NavigationLink(destination: Manage__Enter_Team_Scores(teamid: player.teamId)) {
                                Text(player.name)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .onAppear {
                ReadFromFireBase.getPlayersForEvent(eventId: eventId) { result in
                    switch result {
                    case .success(let players):
                        self.players = players
                    case .failure(let error):
                        print("Error fetching players: \(error.localizedDescription)")
                    }
                }
            }
            .navigationBarTitle("Edit Team Scores", displayMode: .inline)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: EventsTabGameSettingsScreenOneView(eventid: eventId, holeid: holeId)) {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            )
        }
    }
}


struct EventPlannerPresentPlayers_Previews: PreviewProvider {
    static var previews: some View {
        EventPlannerPresentPlayers(eventId: "I6tUwAA2ur2O9JM7Q7Fk", holeId: "5")
    }
}
