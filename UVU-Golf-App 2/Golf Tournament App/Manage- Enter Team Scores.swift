//
//  Manage- Enter Team Scores.swift
//  Golf Tournament App
//
//  Created by Robert Steed on 3/15/23.
//

import SwiftUI

struct Manage__Enter_Team_Scores: View {
//    init(team: Team) {
//        //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        self.team = team
//    }

    
    var teamid: String
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.navigationColor
                    .ignoresSafeArea()
                Color.primaryColor
                    .ignoresSafeArea(edges: .bottom)
                
                VStack {
                    Grid {
                        GridRow {
                            Text("Player Name")
                            Text("Golf Score")
                            Text("Previous Hole")
                                
                        }
                        .foregroundColor(.white)
                        
//                        ForEach(team.players) { player in
//                            Divider()
//                            GridRow {
//                                Text(player.name)
//                                Text("\(player.golfScore)")
//                                Text("4")
//                            }
//                            .foregroundColor(.white)
//                        }
                    }
                    .padding()
                    Spacer()
                }
               // .navigationTitle(team.teamName)
            }
        }
    }
                   
    }
    
//
//struct Manage__Enter_Team_Scores_Previews: PreviewProvider {
//    static var previews: some View {
//        Manage__Enter_Team_Scores(team: Team(teamName: "", players: [Player(name: "", golfScore: 0, contestScores: [:]),Player(name: "", golfScore: 0, contestScores: [:]), Player(name: "", golfScore: 0, contestScores: [:]), Player(name: "", golfScore: 0, contestScores: [:])]))
//    }
//}

            
//            List {
//                HStack {
//                    Text("Player Name")
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity)
//                    Text("Golf Score")
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity)
//                    Text("Previous Hole")
//                        .frame(maxWidth: .infinity)
//                }
//                .listRowBackground(Color(red: 0.4, green: 0.06, blue: 0.1))
//                .listRowSeparatorTint(.white, edges: .bottom)
//                    .foregroundColor(.white)
//                HStack {
//                    Text(team.players[0].name)
//                        .padding(.horizontal)
//
//                    Text("\(team.players[0].golfScore)")
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity)
//                    Text("4")
//                }
//                .listRowBackground(Color(red: 0.4, green: 0.06, blue: 0.1))
//                .listRowSeparatorTint(.white, edges: .bottom)
//                    .foregroundColor(.white)
//                HStack {
//                    Text(team.players[1].name)
//                        .padding(.horizontal)
//
//                    Text("\(team.players[1].golfScore)")
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity)
//                    Text("4")
//                }
//                .listRowBackground(Color(red: 0.4, green: 0.06, blue: 0.1))
//                    .listRowSeparatorTint(.white, edges: .bottom)
//                        .foregroundColor(.white)
//                HStack {
//                    Text(team.players[2].name)
//                        .padding(.horizontal)
//
//                    Text("\(team.players[2].golfScore)")
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity)
//                    Text("4")
//                } .listRowBackground(Color(red: 0.4, green: 0.06, blue: 0.1))
//                    .listRowSeparatorTint(.white, edges: .bottom)
//                        .foregroundColor(.white)
//                HStack {
//                    Text(team.players[3].name)
//                        .padding(.horizontal)
//                    Text("\(team.players[3].golfScore)")
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity)
//                    Text("4")
//                }
//                .listRowBackground(Color(red: 0.4, green: 0.06, blue: 0.1))
//                .listRowSeparatorTint(.white, edges: .bottom)
//                    .foregroundColor(.white)
//
//
//            } .scrollContentBackground(.hidden)
//                .navigationTitle(team.teamName)
//
//        }
//
//    }
//}

