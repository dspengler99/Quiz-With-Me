//
//  FriendsView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 27.05.21.
//

import SwiftUI

struct FriendsView: View {
    @State private var friends: [QuizUser] = [QuizUser(userID: "1", username: "user1"), QuizUser(userID: "2", username: "User2")]

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
        FriendsView()
    }
}
