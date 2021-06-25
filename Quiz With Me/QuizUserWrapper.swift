//
//  QuizUserWrapper.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 15.06.21.
//

import SwiftUI
import Combine
/**
 This class holds the environment object for the game. The wrapper class is needed, because the user can be nil if not signed in. An optional value as an environment object directly seems not supported by swift or atleast not as recomended.
 */
class QuizUserWrapper : ObservableObject {
    @Published var quizUser: QuizUser?

    init() {
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { timer in
            print("Timer fired!")
            guard let oldQuizUser = self.quizUser else {
                return
            }
            DataManager.shared.getUser(uid: oldQuizUser.userID).done { response in
                guard let newQuizUser = response else {
                    return
                }
                self.quizUser = newQuizUser
            }
        }
        
    }
}
