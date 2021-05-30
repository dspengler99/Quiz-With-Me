//
//  FriendRequestRow.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 28.05.21.
//

import SwiftUI

struct FriendRequestRow: View {
    @Binding var friends: [QuizUser]
    var index: Int
    
    var body: some View {
        HStack {
            VStack {
                Text(friends[index].username)
                // TODO Maybe add some more information
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .buttonStyle(PrimaryButton(width: 25, height: 25, fontSize: 15))
            .accessibility(label: Text("Freundschaftsanfrage annehmen"))
        }
    }
}

struct FriendRequestRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestRow(friends: .constant([QuizUser(userID: "1", username: "PreviewUser")]), index: 0)
    }
}
