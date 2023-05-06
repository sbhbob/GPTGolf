//
//  TestView.swift
//  Golf Tournament App
//
//  Created by Tyler Radke on 3/23/23.
//

import SwiftUI

struct TestView: View {
    @State private var holesString: String = ""
    
    var body: some View {
        VStack {
            Button(action: {
                let eventId = "lxuNdkN2wAnxIbOC9QnX" // Replace with the actual event ID as a String
                
                FirestoreManager.readHolesWithListener(from: eventId) { holes in
                    var holesDescription = ""
                    
                    for hole in holes {
                        holesDescription += "Hole Number: \(hole.holeNumber), Sponsor: \(hole.sponsor)\n"
                    }
                    
                    self.holesString = holesDescription
                }
            }) {
                Text("Fetch Holes")
            }
            
            Text(holesString)
                .multilineTextAlignment(.leading)
                .padding()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
