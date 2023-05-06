//
//  Golf_Tournament_AppApp.swift
//  Golf Tournament App
//
//  Created by Brayden Lemke on 3/2/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
     FirebaseApp.configure()
     return true
  }
}

@main
struct Golf_Tournament_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SignIn()
        }
    }
}
