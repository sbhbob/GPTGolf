//
//  RedButtonView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/10/23.
//

import SwiftUI

struct RedButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(red: 0.33, green: 0.03, blue: 0.1)) // secondary
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding([.top], 80)
    }
}

extension View {
    func redButton() -> some View {
        self.modifier(RedButton())
    }
}



