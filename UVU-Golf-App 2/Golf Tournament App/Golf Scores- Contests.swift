//
//  Golf Scores- Contests.swift
//  Golf Tournament App
//
//  Created by Robert Steed on 3/8/23.
//

import SwiftUI

struct Golf_Scores__Contests: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    @State private var contests: [Hole] = []
    
    var body: some View {
        
        let withIndex = contests.enumerated().map({ $0 })
        
        NavigationStack {
            
            ZStack(alignment: .top) {
                Color.navigationColor
                    .ignoresSafeArea()
                Color.primaryColor
                    .ignoresSafeArea(edges: .bottom)
                
                List(withIndex, id: \.element.ID) { index, hole in
                    NavigationLink(destination: Golf_Scores_Sponser_Leaderboard(hole: hole),
                                   label: {
                        VStack(alignment: .leading) {
                            Text("\(hole.holeNumber)- \(hole.sponsor)")
                            
                        }
                    })
                    .listRowBackground(Color(red: 0.4, green: 0.06, blue: 0.1))
                    .listRowSeparatorTint(.white, edges: .bottom)
                    .foregroundColor(.white)
                    
                    .scrollContentBackground(.hidden)
                    
                    .navigationTitle("Contests")
                    
                }
                // Hard coded to use dummy data, need to catch wherever its passed from to here
                .onAppear {
                    FirestoreManager.readHolesWithListener(from: "lxuNdkN2wAnxIbOC9QnX") { fetchedHoles in
                        self.contests = fetchedHoles
                    }
                }
            }
        }
    }
}


struct Golf_Scores__Contests_Previews: PreviewProvider {
    static var previews: some View {
        Golf_Scores__Contests()
    }
}


//ForEach(Array(contests.enumerated()), id: \.offset) { index,contest in
//    Text(value: contests) {
//        TestView(contest: contest)


// I need to collect the sponsors for every hole and place them here, this is for the whole event I think

// Then have a link that takes you to the contest with a leaderboard of the top players

// query for sponsors: /eventPlanners/ADK9Dr3AvhOOQ3U2kP4t/events/lxuNdkN2wAnxIbOC9QnX/holes

// /eventPlanners/CurrentUser.
