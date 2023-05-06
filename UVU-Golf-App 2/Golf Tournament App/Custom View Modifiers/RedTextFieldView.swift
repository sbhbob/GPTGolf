//
//  RedTextFieldView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/10/23.
//

import SwiftUI

struct RedTextField: View {
    var label: String
    var bind: Binding<String>
    
    var body: some View {
        VStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading], 20)
            TextField("", text: bind)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.33, green: 0.03, blue: 0.1)))// .secondary
                .foregroundColor(.white)
        }
    }
}


