//
//  Create-Team.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 5/3/23.
//

import SwiftUI

struct Create_Team: View {
    @Environment(\.dismiss) var dismiss

    @State private var leaderName = ""
    @State private var player2Name = ""
    @State private var player3Name = ""
    @State private var player4Name = ""
    
    @State private var companyName = ""

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 5) {
                VStack {
                    Text("Team Leader")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                    TextField("Name", text: $leaderName)
                        .squareSecondaryTextField(width: 375, height: 45, show: leaderName.isEmpty, text: "Name")
                    TextField("Company", text: $companyName)
                        .squareSecondaryTextField(width: 375, height: 45, show: companyName.isEmpty, text: "Company")
                        .padding(.top, 5)
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                        Text("It is only required that a team leader is added. Team members can be adder by hole managers on the first whole the team plays during the tournament.")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    .padding(5)
                }

                VStack(spacing: 5) {
                    Text("Player 2")
                        .leftLeadingText()
                    TextField("Name", text: $player2Name)
                        .squareSecondaryTextField(width: 375, height: 45, show: player2Name.isEmpty, text: "Name")
                }
                .padding(.top, 5)

                VStack(spacing: 5) {
                    Text("Player 3")
                        .leftLeadingText()
                    TextField("Name", text: $player3Name)
                        .squareSecondaryTextField(width: 375, height: 45, show: player3Name.isEmpty, text: "Name")
                }
                .padding(.top, 5)

                VStack(spacing: 5) {
                    Text("Player 4")
                        .leftLeadingText()
                    TextField("Name", text: $player4Name)
                        .squareSecondaryTextField(width: 375, height: 45, show: player4Name.isEmpty, text: "Name")
                }
                .padding(.top, 5)
                
                Spacer()
                    .frame(height: 30)
                HStack {
                    Spacer()
                    Button("Create Team") {
                        createPlayers()
                    }
                    .roundDarkButton()
                    Spacer()
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
        .navigationTitle("Create Team")
    }
}

extension Create_Team {
    // MARK: Functions
    
    func createPlayers() {
        var playerName = ""
        let teamID = UUID().uuidString
        
        for i in 1...4 {
            switch i {
            case 1:
                if !leaderName.isEmpty {
                    playerName = leaderName
                } else {
                    continue
                }
            case 2:
                if !player2Name.isEmpty {
                    playerName = player2Name
                } else {
                    continue
                }
            case 3:
                if !player3Name.isEmpty {
                    playerName = player3Name
                } else {
                    continue
                }
            case 4:
                if !player4Name.isEmpty {
                    playerName = player4Name
                } else {
                    continue
                }
            default:
                print("Extreme error with creating players")
            }
            
            let player = Player(name: playerName, teamId: teamID, holeScores: [:], contestScores: [:])
            
            WriteToFirebase().addPlayer(eventId: User.staticEventId ?? "", player: player) { result in
                print("Player \(player.name) has been added.")
            }
        }
        leaderName = ""
        companyName = ""
        player2Name = ""
        player3Name = ""
        player4Name = ""
        dismiss()
    }
}

struct Create_Team_Previews: PreviewProvider {
    static var previews: some View {
        Create_Team()
    }
}
