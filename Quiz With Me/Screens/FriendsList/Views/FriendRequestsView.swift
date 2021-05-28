//
//  FriendRequestsView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 27.05.21.
//

import SwiftUI

struct FriendRequestsView: View {
    @Binding var friendRequests: [QuizUser]
    
    var body: some View {
        List {
            ForEach(0..<friendRequests.count) { index in
                FriendRequestRow(friends: $friendRequests, index: index)
            }
        }
    }
}

struct FriendRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestsView(friendRequests: .constant([QuizUser(userID: "abcd", username: "PreviewUser")]))
    }
}
