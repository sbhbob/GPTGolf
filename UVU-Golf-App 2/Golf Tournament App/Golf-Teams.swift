//
//  Golf-Teams.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 5/3/23.
//

import SwiftUI

struct Golf_Teams: View {
    @State var searchText = ""
    var body: some View {
        ZStack(alignment: .top) {
            VStack {

            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(Color.primaryColor)
            .searchable(text: $searchText)
            
            
            GeometryReader { reader in
                Color.navigationColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle("Golf Teams")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    Create_Team()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct Golf_Teams_Previews: PreviewProvider {
    static var previews: some View {
        Golf_Teams()
    }
}
