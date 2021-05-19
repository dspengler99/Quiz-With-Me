//
//  LoginRegisterScreen.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 19.05.21.
//

import SwiftUI

struct LoginRegisterScreen: View {
    @State private var viewState: ViewState = ViewState.LOGIN
    var body: some View {
        switch viewState {
        case .LOGIN:
            LoginView(viewState: $viewState)
        case .REGISTER:
            RegisterView(viewState: $viewState)
        }
    }
}

struct LoginRegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterScreen()
    }
}
