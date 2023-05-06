//
//  HoleManagerTabView.swift
//  Golf Tournament App
//
//  Created by Tyler Radke on 4/10/23.
//

import SwiftUI

struct HoleManagerTabView: View {
    @Binding var holeManagerInitialPresented: Bool
    @Binding var isLoading: Bool
    
    var body: some View {
        TabView {
            HoleManagerInitialScreen()
                .tabItem {
                    Label("All Holes", systemImage: "info.circle")
                }
            
            ManageHoleSettingsScreenView()
                .tabItem {
                    Label("Manage", systemImage: "list.bullet.clipboard")
                }
            
            HoleManagerSettingsView(holeManagerInitialPresented: $holeManagerInitialPresented)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            isLoading = false
        }
    }
}

struct HoleManagerTabView_Previews: PreviewProvider {
    static var previews: some View {
        HoleManagerTabView(holeManagerInitialPresented: .constant(true), isLoading: .constant(true))
    }
}
