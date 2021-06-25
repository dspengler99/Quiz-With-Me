//
//  Quiz_With_MeApp.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 11.05.21.
//

import SwiftUI
import Firebase

/**
 This is the starting point of the app. If credentials of a user are saved on the device the user is taken to the home-screen. Othervice he will see the login and registration screen.
 
 Also the user from the database is loaded here and an object of type `QuizUserWrapper` is passed into the view as an environment object.
 */
@main
struct Quiz_With_MeApp: App {
    
    var quizUserWrapper: QuizUserWrapper = QuizUserWrapper()
    @State var isFinished = false
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if isFinished {
                    Main(viewState: AuthenticationManager.shared.foundCredentials() ? .HOME : .LOGIN)
                    .environmentObject(quizUserWrapper)
                }
            }.onAppear {
                if let uid = Auth.auth().currentUser?.uid {
                    _ = DataManager.shared.getUser(uid: uid).done {
                        response in
                        if let quizUser = response {
                            quizUserWrapper.quizUser = quizUser
                        }
                        isFinished = true
                    }
                } else {
                    isFinished = true
                }
            }
        }
    }
}
