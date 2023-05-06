//
//  EventsTabView.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 4/18/23.
//

import SwiftUI

struct EventsTabView: View {
    @Binding var adminInitialPresented: Bool

    @Binding var isLoading: Bool

    var body: some View {
        TabView() {
            AdminEventScreen()
                .tabItem {
                    Label("Events", systemImage: "list.bullet.rectangle.portrait.fill")
                }
            EventPlannerSettingsView(adminInitialPresented: $adminInitialPresented)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            isLoading = false
        }
    }
}

struct EventsTabView_Previews: PreviewProvider {
    static var previews: some View {
        EventsTabView(adminInitialPresented: .constant(true), isLoading: .constant(true))
    }
}
