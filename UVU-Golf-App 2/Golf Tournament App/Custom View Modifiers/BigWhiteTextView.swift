//
//  BigWhiteTextView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/10/23.
//

import SwiftUI

struct BWText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading], 20)
    }
}
