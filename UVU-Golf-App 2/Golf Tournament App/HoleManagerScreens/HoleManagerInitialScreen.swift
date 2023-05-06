//
//  HoleManagerInitialScreen.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 3/31/23.
//

import SwiftUI

struct HoleManagerInitialScreen: View {
    let holeSponsers = ["UCCU", "Zions Bank", "Sponsor Here", "Sponsor Here", "Sponsor Here", "Sponsor Here", "Sponsor Here", "Sponsor Here"]
        
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack {
                    VStack(spacing: 1) {
                        Text("DESCRIPTION")
                            .foregroundColor(.white.opacity(0.5))
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        Text("Welcome to the UVU Golf Tournament! This is a sample description where general information about the tournament can be displayed.")
                            .foregroundColor(.white)
                    }
                    Divider()
                        .editDivideLine(width: 305)
                    VStack(spacing: 1) {
                        Text("LOCATION")
                            .foregroundColor(.white.opacity(0.5))
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        Text("730 S Sleepy Ridge Dr, Orem, UT 84058")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    Divider()
                        .editDivideLine(width: 305)
                    VStack(spacing: 1) {
                        Text("HOLE SPONSORS")
                            .foregroundColor(.white.opacity(0.5))
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        List {
                            Section {
                                ForEach(Array(holeSponsers.enumerated()), id: \.offset) { i, sponsor in
                                    Text("\(i + 1) - \(sponsor)")
                                        .foregroundColor(.white)
                                }
                            }
                            .listRowSeparatorTint(Color.white)
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(.inset)
                        .scrollContentBackground(.hidden)
                    }
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
            .navigationTitle("UVU Golf Tournament")
        }
    }
}
        

struct HoleManagerInitialScreen_Previews: PreviewProvider {
    static var previews: some View {
        HoleManagerInitialScreen()
    }
}
