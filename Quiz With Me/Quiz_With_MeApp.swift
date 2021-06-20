//
//  Quiz_With_MeApp.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 11.05.21.
//

import SwiftUI
import Firebase

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
                    Main(viewState: AuthenticationManager.shared.foundCredentials() ? .PROFILE : .LOGIN)
                    .environmentObject(quizUserWrapper)
                }
            }.onAppear {
                if let uid = Auth.auth().currentUser?.uid {
                    DataManager.shared.getUser(uid: uid).done {
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
