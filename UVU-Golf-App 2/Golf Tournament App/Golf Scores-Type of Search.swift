//
//  Golf Scores-Type of Search.swift
//  Golf Tournament App
//
//  Created by Robert Steed on 3/7/23.
//

import SwiftUI

struct Golf_Scores_Type_of_Search: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
       
            
            NavigationStack {
                ZStack(alignment: .top) {
                    Color.navigationColor
                        .ignoresSafeArea()
                    Color.primaryColor
                        .ignoresSafeArea(edges: .bottom)
                    
                    VStack {
                        Spacer()
                        
                        NavigationLink("Golf Scores", destination:  Golf_Scores__Team_Leaderboard())
                    
                            .font(
                                .title
                                    )
                    
                            .frame(height: 75)
                            .frame(maxWidth: .infinity)
                            .buttonStyle(.bordered)
                            .tint(Color(red: 0.0, green: 0.0, blue: 0.149))
                            .controlSize(.large)
                            .foregroundColor(.white)
                            .padding()
                        
                         NavigationLink("Contest Scores", destination: Golf_Scores__Contests())
                          
                        
                            .font(
                                .title
                                    )
                        
                            .frame(height: 75)
                            .frame(maxWidth: .infinity)
                            .buttonStyle(.bordered)
                            .tint(Color(red: 0.0, green: 0.0, blue: 0.149))
                            .controlSize(.large)
                            .foregroundColor(.white)
                            .padding()
                        
//                        NavigationLink("Poker Leaderboard", destination: Golf_Scores__Poker_Leaderboard())
//
//                            .font(
//                                .title
//
//                                   )
//
//                            .frame(height: 75)
//                            .frame(maxWidth: .infinity)
//                            .buttonStyle(.bordered)
//                            .tint(Color(red: 0.0, green: 0.0, blue: 0.149))
//                            .controlSize(.large)
//                            .foregroundColor(.white)
//                            .padding()
                        Spacer()
                    }
                    .navigationTitle("Score Options")
                  
                    }
                }
            
        }
    }


    
    
    
    struct Golf_Scores_Type_of_Search_Previews: PreviewProvider {
        static var previews: some View {
            Golf_Scores_Type_of_Search()
        }
    }

