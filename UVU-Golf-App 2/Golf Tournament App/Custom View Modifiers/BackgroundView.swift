//
//  ContentView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/8/23.
//

import SwiftUI

struct BackgroundView: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.primaryColor
                .ignoresSafeArea()
            
//            GeometryReader { reader in
//                Color.navigationColor
//                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
//                .ignoresSafeArea()}
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

