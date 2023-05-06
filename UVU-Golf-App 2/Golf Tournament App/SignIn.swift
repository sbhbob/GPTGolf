//
//  ContentView.swift
//  Golf Tournament App
//
//  Created by Brayden Lemke on 3/2/23.
//

import SwiftUI
import Firebase

struct SignIn: View {

    @State private var emailStr = "michaelbwhiting2004@gmail.com"
    @State private var passwordStr = "password"
    @State var uid = ""
    
    @State var adminInitialPresented = false
    @State var holeManagerInitialPresented = false
    @State var isLoading = false
    
    @State var signInError = false
    
    let data = ["String": "String"]
    

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                // MARK: Title Label
                Text("⛳️ Tournament")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                // MARK: Email TextField
                VStack(spacing: 10) {
                    TextField("Email", text: $emailStr)
                        .clearTextField(show: emailStr.isEmpty, text: "Email")
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Divider()
                        .editDivideLine(width: 250)
                }
                
                // MARK: Password TextField
                VStack(spacing: 10) {
                    SecureField("Password", text: $passwordStr)
                        .clearTextField(show: passwordStr.isEmpty, text: "Password")
                    Divider()
                        .editDivideLine(width: 250)
                }
                
                if signInError {
                    HStack {
                        Spacer()
                        Text("Error with signing in, perhaps email or password is incorrect.")
                            .foregroundColor(.red)
                            .bold()
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
            
                if isLoading {
                    CustomLoadCircle()
                }
                
                // MARK: Sign In Button
                Button("Sign In") {
                    withAnimation {
                        isLoading.toggle()
                    }
                    signIn()
                }
                .roundDarkButton()
                
                Spacer()
                
                // MARK: Sign Up Button
                NavigationLink {
                    SignUp(adminInitialPresented: $adminInitialPresented, holeManagerInitialPresented: $holeManagerInitialPresented)
                } label: {
                    Text("Dont have a tournament?\n Sign up here to create a tournament")
                        .roundDarkButton()
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
            .fullScreenCover(isPresented: $adminInitialPresented) {
                EventsTabView(adminInitialPresented: $adminInitialPresented, isLoading: $isLoading)
            }
            .fullScreenCover(isPresented: $holeManagerInitialPresented) {
                HoleManagerTabView(holeManagerInitialPresented: $holeManagerInitialPresented, isLoading: $isLoading)
            }
        }
    }
}

extension SignIn {
    // MARK: Functions
    func signIn() {
        Auth.auth().signIn(withEmail: emailStr, password: passwordStr) { result, error in
            if error != nil {
                withAnimation {
                    signInError = true
                    isLoading = false
                }
                print("Error with signing in, perhaps user does not exist")
            } else {
                withAnimation {
                    signInError = false
                }
                print("User has been signed in!")
                var userType = ""
                if let userUID = result?.user.uid {
                    let db = Firestore.firestore()
                    let docRef = db.collection("Users").document("\(userUID)")
                    
                    docRef.getDocument { (document, error) in
                        if let document, document.exists {
                            let data: [String: Any]? = document.data() ?? [:]
                            let userTypeInfo = data?.first(where: { $0.key == "userType"})
                            userType = String("\(userTypeInfo!.value)")
                            
                            switch userType {
                            case "eventPlanner":
                                adminInitialPresented.toggle()
                            case "holeManager":
                                holeManagerInitialPresented.toggle()
                            default:
                                print("Error: User does not have userType")
                            }
                            emailStr = ""
                            passwordStr = ""
                        } else {
                            print("Error, document does not exist")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
