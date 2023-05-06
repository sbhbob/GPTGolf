//
//  AdminEventScreen.swift
//  Golf Tournament App
//
//  Created by Tyler Radke on 3/16/23.
//

import SwiftUI
import Firebase


struct AdminEventScreen: View {
    // @State var eventPlanner: [EventPlanner] = []
    @State private var user = Auth.auth().currentUser
    @State var events: [Event] = []
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().backgroundColor = .black
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.navigationColor
                
                //                let maroon = Color(red: 0.4, green: 0.06, blue: 0.1)
                Color.primaryColor
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in
                    VStack(alignment: .center){
                        ScrollView {
                            Spacer()
                                .frame(height: 10)
                            ForEach(events, id: \.self) { event in
                                NavigationLink {
                                    EventDetailView(event: event)
                                } label: {
                                    VStack(spacing: 10) {
                                        HStack {
                                            Text(event.title)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.white)
                                                .padding(.trailing)
                                        }
                                        Divider()
                                            .editDivideLine(width: 305)
                                    }
                                    .padding(.bottom, -5)
                                }
                                .background {
                                    Color.clear
                                        .frame(width: geometry.size.width * 0.9, height: 25, alignment: .center)
                                        .cornerRadius(50)
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            }
                        }
                        .background(Color.secondaryColor)
                    }
                    .navigationTitle("Your Events")
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: {
                                CreateEditEvent()
                            }) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .frame(width: geometry.size.width, alignment: .center)
                } .task {
                    ReadFromFireBase.getCurrentUserData { result in
                        switch result {
                        case .success(let user):
                            let eventIds = user.eventIds ?? []
                            print(user)
                            
                            ReadFromFireBase.getEventsData(for: eventIds) { eventsResults in
                                self.events = eventsResults
                                
                            }
                        case .failure(let error):
                            print("Error fetching user data: \(error)")
                        }
                    }
                }
            }
        }
    }
}

struct AdminEventScreen_Previews: PreviewProvider {
    static var previews: some View {
        AdminEventScreen()
    }
}
