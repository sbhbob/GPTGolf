//
//  ContentView.swift
//  Golf Tournament App
//
//  Created by Brayden Lemke on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
        
                
                ZStack(alignment: .top) {
                    
                    Color(red: 0.4, green: 0.06, blue: 0.1)
                        .ignoresSafeArea()
                    
                    GeometryReader { reader in
                        Color.black
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .ignoresSafeArea()}
                }
            }
    }


extension Color {
    public static var primary: Color {
        return Color(red: 0.4, green: 0.06, blue: 0.1)
    }
    public static var secondary: Color {
        return Color(red: 0.33, green: 0.03, blue: 0.1)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}