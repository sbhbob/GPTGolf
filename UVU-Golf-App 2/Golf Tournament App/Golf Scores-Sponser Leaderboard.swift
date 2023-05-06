//
//  Golf Scores-Sponser Leaderboard.swift
//  Golf Tournament App
//
//  Created by Robert Steed on 3/9/23.
//

import SwiftUI

struct Golf_Scores_Sponser_Leaderboard: View {
    
    init(hole: Hole) {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.hole = hole
    }
    
    var hole: Hole
    
    @State private var players: [Player] = []
    
    //The evaluatePlayer() function sorts the players array based on their contest scores for the given hole:
    // The sorted function takes a closure to compare two players and returns a boolean value indicating whether the first player should appear before the second player in the sorted array. In this case, it compares the contest scores for the given hole number and sorts them in descending order.
    func evaluatePlayer() -> [Player] {
       // let sortedPlayers = players.sorted { $0.contestScores[hole.holeNumber]! > $1.contestScores[hole.holeNumber]! }
       // return sortedPlayers
        
        return []
    }
    
    var body: some View {
        
        //In the List, we create a new array called withIndex that contains the index and the corresponding sorted player:
        //enumerated() function returns a sequence of pairs (index, player), and map({ $0 }) simply returns the same pairs in an array.
        let withIndex = evaluatePlayer().enumerated().map({ $0 })
        
        NavigationStack {
        ZStack(alignment: .top) {
            Color.navigationColor
                .ignoresSafeArea()
            Color.primaryColor
                .ignoresSafeArea(edges: .bottom)
            
            // The List iterates through the withIndex array and displays the player's name and their contest score for the given hole:
            // The badge modifier displays the contest score for the specific hole using the hole.holeNumber. It accesses the player's contestScores dictionary with the hole number as the key:
            // This expression looks up the contest score for the given hole in the contestScores dictionary and formats it using the formatted() function (assumed to be an extension on Int). If there is no contest score for the given hole, the expression returns nil, and the badge won't be displayed.
            List(withIndex, id: \.element.name) { index, player in
                
                Text("\(index + 1). \(player.name)")
                //  .badge(player.contestScores[hole.holeNumber]?.formatted())
                    .listRowBackground(Color(red: 0.4, green: 0.06, blue: 0.1))
                    .listRowSeparatorTint(.white, edges: .bottom)
                        .foregroundColor(.white)
                    
                }
                // Grabs the Players off of the event. Still uses hardcoded data, need to store it or pass it from somewhere
                .onAppear {
                    FirestoreManager.readPlayersWithListener(from: "lxuNdkN2wAnxIbOC9QnX") { fetchedPlayers in
                        players = fetchedPlayers
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Leaderboard for Hole \(hole.holeNumber)")
            }
        }
    }
}


//struct Golf_Scores_Sponser_Leaderboard_Previews: PreviewProvider {
//    static var previews: some View { Golf_Scores_Sponser_Leaderboard(contest: Contest(contestTitle: "", whoWins: .highScore, unit: ""))
//    }
//}
