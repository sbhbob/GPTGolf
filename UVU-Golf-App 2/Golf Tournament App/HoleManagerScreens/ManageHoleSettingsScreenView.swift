//
//  GameSettingsScreenOneView.swift
//  Golf Tournament App
//
//  Created by Skyler Hope on 3/8/23.
//

import SwiftUI

struct ManageHoleSettingsScreenView: View {
    
    @State private var whoWinsPickerSelection: Int = 0
    @State private var scoreUnitTextField: String = ""
    @State private var descriptionTextField: String = ""
    
    @State private var eventId: String = ""
    @State private var holeId: String = ""
    
    @Environment(\.dismiss) var dismiss
    //  @State private var
    
    // change the segmented picker's colors
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.secondaryColor)
        // color above should be .secondary eventually
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    Text("Who Wins")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading], 34)
                        .padding([.top], 60)
                    Picker("Who Wins: ", selection: $whoWinsPickerSelection) {
                        Text("Highest Wins").tag(0)
                        Text("Lowest Wins").tag(1)
                    } .pickerStyle(.segmented)
                    
                    VStack {
                        BWText(text: "Score Unit")
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
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondaryColor))// .secondary
                            .foregroundColor(.white)
                            .tint(.white)
                    }
                    Text("Game Description")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                    
                    HStack {                        TextField("Description", text: $descriptionTextField)
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondaryColor))// .secondary
                            .foregroundColor(.white)
                    }
                    Button("Save Game Settings") {
                        //save game settings
                        ReadFromFireBase.updateHole("gameDescription", with: descriptionTextField, for: holeId, in: eventId)

                        ReadFromFireBase.updateHole("scoringUnit", with: scoreUnitTextField, for: holeId, in: eventId)

                        ReadFromFireBase.updateHole("whoWins", with: "\(WhoWins.allCases[whoWinsPickerSelection])", for: holeId, in: eventId)
                        
                        print(WhoWins.allCases[whoWinsPickerSelection])
                        
                    }
                    .padding()
                    .background(Color.secondaryColor) // secondary
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding([.top], 80)
                    
                    Spacer()
                }
            }
            .navigationTitle("Game Settings")
            .navigationBarItems(leading: Button("< 1 - UCCU"){
                dismiss()
            })
            .task {
                let _ = ReadFromFireBase.getCurrentUserData { result in
                    let user: User?

                    do {
                        user = try result.get()
                    } catch {
                        print("error getting user")
                        user = nil
                    }
                    
                    guard let user, let eventId = user.eventId, let holeId = user.holeId else { return }
                    ReadFromFireBase.getManagerHole(eventId: eventId, holeId: holeId) { hole in
                        whoWinsPickerSelection = (hole.whoWins == .highScore) ? 1 : 0
                        scoreUnitTextField = hole.scoringUnit
                        descriptionTextField = hole.gameDescription
                        
                        self.eventId = eventId
                        self.holeId = holeId
                    }
                }
            }
        }
    }
}
    
struct ManageHoleSettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}

