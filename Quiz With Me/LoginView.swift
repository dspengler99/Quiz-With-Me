//
//  LoginView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 13.05.21.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        Text("Test")
            .onAppear() {
                AuthenticationManager().signupWith(username: "testUser2", email: "test3@test.de", and: "HalloIhrDa123")
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
