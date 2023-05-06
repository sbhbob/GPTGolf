//
//  Golf Scores- Team Leaderboard.swift
//  Golf Tournament App
//
//  Created by Robert Steed on 3/7/23.
//

import SwiftUI

struct Golf_Scores__Team_Leaderboard: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
//        Team(teamName: "The Leaping Lizards", players: [
//            Player(name: "Schmitterwegerjegermanjenson", golfScore: 80, contestScores: [1: 10]),
//            Player(name: "Player 2", golfScore: 75, contestScores: [1: 30]),
//            Player(name: "Player 3", golfScore: 92, contestScores: [1: 25]),
//            Player(name: "Player 4", golfScore: 130, contestScores: [1: 100])
//        ]),
//        Team(teamName: "The Wombat Slayers", players: [
//            Player(name: "Player A", golfScore: 100, contestScores: [1: 70]),
//            Player(name: "Player B", golfScore: 110, contestScores: [1: 80]),
//            Player(name: "Player C", golfScore: 120, contestScores: [1: 90]),
//            Player(name: "Player D", golfScore: 130, contestScores: [1: 100])
//        ]),
//        Team(teamName: "The Hamburglers", players: [
//            Player(name: "Player A1", golfScore: 150, contestScores: [1: 150]),
//            Player(name: "Player B2", golfScore: 175, contestScores: [1: 175]),
//            Player(name: "Player C3", golfScore: 200, contestScores: [1: 200]),
//            Player(name: "Player D4", golfScore: 130, contestScores: [1: 100])
//        ])
  //  ]
    
    
    
    var body: some View {
        
      //  let withIndex = team.enumerated().map({ $0 })
        
        NavigationStack {
        ZStack(alignment: .top) {
            Color.navigationColor
                .ignoresSafeArea()
            Color.primaryColor
                .ignoresSafeArea(edges: .bottom)
            
//            List(withIndex, id: \.element.teamName) { index, team in
//                NavigationLink(destination: Manage__Enter_Team_Scores(team: team),
//                               label: {
//                    VStack(alignment: .leading) {
//                        Text("\(index + 1). \(team.teamName)")
//                       
//                    }
//                })
//                .listRowBackground(Color.clear)
//                .listRowSeparatorTint(.white, edges: .bottom)
//                    .foregroundColor(.white)
//            }
            .scrollContentBackground(.hidden)

                 .navigationTitle("Contests")
                
            }
            
        }
    }
}

struct Golf_Scores__Team_Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Golf_Scores__Team_Leaderboard()
    }
}
