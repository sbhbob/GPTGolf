//
//  SettingsView.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 4/9/23.
//

import SwiftUI
import FirebaseAuth

struct EventPlannerSettingsView: View {
    @Binding var adminInitialPresented: Bool
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack {
                    Button("Sign Out") {
                        try? Auth.auth().signOut()
                        adminInitialPresented = false
                    }
                    .roundDarkButton()
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .background(Color.primaryColor)
                
                GeometryReader { reader in
                    Color.navigationColor
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct EventPlannerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        EventPlannerSettingsView(adminInitialPresented: .constant(true))
    }
}
