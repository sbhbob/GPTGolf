//
//  SignUp.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 3/7/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignUp: View {
    @State private var emailStr = ""
    @State private var passwordStr = ""
    @State private var confirmPasswordStr = ""
    @State var showPasswordError = false
    @State var showSignUpError = false
    @State var isLoading = false
    
    @Binding var adminInitialPresented: Bool
    @Binding var holeManagerInitialPresented: Bool
    
    // This is what changes the navigation title's font color
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 40) {
                Spacer()
                // Email TextField
                Group {
                    VStack(spacing: 10) {
                        TextField("Email", text: $emailStr)
                            .clearTextField(show: emailStr.isEmpty, text: "Email")
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        Divider()
                            .editDivideLine(width: 250)
                    }
                    // Password TextField
                    VStack(spacing: 10) {
                        SecureField("Password", text: $passwordStr)
                            .clearTextField(show: passwordStr.isEmpty, text: "Password")
                            .onChange(of: passwordStr) { newValue in
                                withAnimation {
                                    showPasswordError = passwordStr != confirmPasswordStr
                                }
                            }
                        Divider()
                            .editDivideLine(width: 250)
                    }
                    // Confirm Password TextField
                    VStack(spacing: 10) {
                        SecureField("Confirm Password", text: $confirmPasswordStr)
                            .clearTextField(show: confirmPasswordStr.isEmpty, text: "Confirm Password")
                            .onChange(of: confirmPasswordStr) { newValue in
                                withAnimation {
                                    showPasswordError = passwordStr != confirmPasswordStr
                                }
                            }
                        Divider()
                            .editDivideLine(width: 250)
                    }
                }
               
                if showPasswordError {
                    Text("Passwords do not match")
                        .foregroundColor(.red)
                        .bold()
                }
                
                if showSignUpError {
                    HStack {
                        Spacer()
                        Text("Error with signing up. May be an incorrect email or an already existing account.")
                            .foregroundColor(.red)
                            .bold()
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                
                if isLoading {
                    CustomLoadCircle()
                }
                
                Button("Sign Up") {
                    withAnimation {
                        isLoading = true
                    }
                    register()
                }
                .roundDarkButton()
                
                HStack {
                    Image(systemName: "info.circle")
                    Text("By creating this account you will be the designated event admin/planner")
                        .font(.subheadline)
                }
                Spacer()
                Spacer()
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
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.large)

        .foregroundColor(.white)
    }
}

extension SignUp {
    // MARK: Functions
    func register() {
        if showPasswordError {
            print("Error has been showing, exiting function ")
            withAnimation {
                isLoading = false
            }
            return
        }
        
        Auth.auth().createUser(withEmail: emailStr, password: passwordStr) { result, error in
            if error != nil {
                withAnimation {
                    showSignUpError = true
                    isLoading = false
                }
                print("Error with signing up")
            } else {
                withAnimation {
                    showSignUpError = false
                }
                let db = Firestore.firestore()

                if let userUID = result?.user.uid {
                    let userDocRef = db.collection("Users").document(userUID)
                
                    userDocRef.setData(["user": userUID, "userType": "eventPlanner", "email": emailStr]) { error in
                        if let error = error {
                            print("Error writing document: \(error)")
                        } else {
                            print("EventPlanner: \(userUID) successfully written!")
                        }
                    }
                    
                    let eventPlannersDocRef = db.collection("eventPlanners").document(userUID)
                    
                    eventPlannersDocRef.setData(["userID": userUID]) { error in
                        if let error = error {
                            print("Error writing eventPlanner document: \(error)")
                        } else {
                            print("EventPlanner: \(userUID) added to eventPlanners")
                        }
                    }
                    
                    signIn()
                }
            }
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: emailStr, password: passwordStr) { result, error in
            if error != nil {
                print("Error with signing in, perhaps user does not exist")
            } else {
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
                            confirmPasswordStr = ""
                        } else {
                            print("Error, document does not exist")
                        }
                    }
                }
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(adminInitialPresented: .constant(false), holeManagerInitialPresented: .constant(false))
    }
}
