//
//  Event Dashboard.swift
//  Golf Tournament App
//
//  Created by Tyler Radke on 3/9/23.
//

import SwiftUI


struct Event_Dashboard: View {
    var body: some View {
        NavigationView {
                VStack() {
                    Text("Description")
                        .turnToHeader()
                    Text("The Actual Description")
                    Divider()
                    Text("Location")
                        .turnToHeader()
                    Text("The Location")
                    Divider()
                    Text("Golf Game")
                        .turnToHeader()
                    Text("Description of Game")
                    Divider()
                    Text("Golf Teams")
                    
                }
                VStack {
                    Text("List of teams here")
                    Divider()
                    Text("Sponsor list here")
                }
            }
        }
    }


struct Event_Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Event_Dashboard()
    }
}

struct IsHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.headline)
            .font(.system(size: 10))
            .padding(10)
            .foregroundColor(Color.gray)
    }
}

extension View {
    func turnToHeader() -> some View {
        modifier(IsHeader())
    }
}
