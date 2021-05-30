//
//  FriendRow.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 28.05.21.
//

import SwiftUI

struct FriendRow: View {
    @Binding var friends: [QuizUser]
    var index: Int
    
    var body: some View {
        HStack {
            VStack {
                Text(friends[index].username)
                // TODO add amount of total played games of this friend
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "trash")
            }
            .buttonStyle(PrimaryButton(width: 25, height: 25, fontSize: 15))
            .accessibility(label: Text("Freund entfernen"))
        }
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friends: .constant([QuizUser(userID: "1", username: "PreviewUser")]), index: 0)
    }
}
