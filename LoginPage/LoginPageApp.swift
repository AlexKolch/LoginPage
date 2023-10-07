//
//  LoginPageApp.swift
//  LoginPage
//
//  Created by Алексей Колыченков on 29.09.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct LoginPageApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
