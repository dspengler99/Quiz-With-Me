//
//  FriendsView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 27.05.21.
//

import SwiftUI

struct FriendsView: View {
<<<<<<< HEAD
    @Binding var friends: [QuizUser]

=======
>>>>>>> parent of 71530d0 (Added list of accepted friends. This list is not generated dynamically right now, because no db-functionality is available)
    var body: some View {
        Text("Hier werden die Freunde gelistet")
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(friends: .constant([QuizUser(userID: "abcd", username: "PreviewUser")]))
    }
}
