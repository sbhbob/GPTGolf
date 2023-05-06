//
//  GameSettingsScreenTwoView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/9/23.
//

import SwiftUI

struct EventsTabGameSettingsScreenOneView: View {
    @State private var whoWinsPickerSelection: Int = 0
    @State private var scoreUnitTextField: String = ""
    @State private var descriptionTextField: String = ""
    
    @State var hole: Hole
    
    @Environment(\.dismiss) var dismiss
    
    // change the segmented picker's colors
//    init() {
//        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.secondaryColor)
//        // color above should be .secondary eventually
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//    }
    
    var body: some View {
        NavigationView {

                VStack {
                    InfoTextView(text: "Leave Game Settings blank if you want the hole manager to determine the game")
                        .padding(.top)
                    Text("Who Wins")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                        .padding()
                    Picker("Who Wins: ", selection: $whoWinsPickerSelection) {
                        Text("Highest Wins").tag(0)
                        Text("Lowest Wins").tag(1)
                    } .pickerStyle(.segmented)
                    
                    VStack {
                        Text("Score Unit")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading], 20)
                        Text("(ex. ft, yd, lbs)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading], 20)
                    }
                    .padding()
                    
                    HStack {
                        TextField("Unit (ex. ft, yd, lbs)", text: $scoreUnitTextField)
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 50).fill(Color.secondaryColor))// .secondary
                            .foregroundColor(.white)
                            .tint(.white)
                    }
                    
                    Text("Game Description")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                    
                    HStack {
                        TextField("Description", text: $descriptionTextField)
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 50).fill(Color.secondaryColor))// .secondary
                            .foregroundColor(.white)
                    }
                    Button("Save Game Settings") {
                        //save game settings
                    }
                    .padding()
                    .background(Color.secondaryColor) // secondary
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding([.top], 80)
                    
                    NavigationLink("Add/View Hole Manager") {
                        EventsTabAddViewHoleManagerScreenView(hole: $hole)
                    }
                    .roundDarkButton()
                }
                .background(Color.primaryColor)

                //                .padding(.top)
                GeometryReader { reader in
                    Color.navigationColor
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("Game Settings")
        }
}

struct EventsTabGameSettingsScreenOneView_Previews: PreviewProvider {
    static var previews: some View {
        EventsTabGameSettingsScreenOneView(hole: Hole(sponsor: "Sponsor", holeNumber: 1, whoWins: .lowScore, scoringUnit: "Points", gameDescription: "Description", isPoker: false))
    }
}
