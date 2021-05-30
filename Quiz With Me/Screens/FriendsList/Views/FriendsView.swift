//
//  FriendsView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 27.05.21.
//

import SwiftUI

struct FriendsView: View {
    @Binding var friends: [QuizUser]

    var body: some View {
        List {
            ForEach(0..<friends.count) { index in
                FriendRow(friends: $friends, index: index)
            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(friends: .constant([QuizUser(userID: "abcd", username: "PreviewUser")]))
    }
}
