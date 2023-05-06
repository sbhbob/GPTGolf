//
//  InfoTextView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/10/23.
//

import SwiftUI

struct InfoTextView: View {
    
    var text: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(.white, lineWidth: 1)
                
                Text("i")
                    .foregroundColor(.white)
            }
            .frame(width: 20, height: 20)
            
            Text(text)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
    }
}

//struct InfoTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoTextView()
//    }
//}
