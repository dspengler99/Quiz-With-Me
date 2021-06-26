//
//  LoginRegisterScreen.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 19.05.21.
//

import SwiftUI

/**
 This screen renders the login or registration screen. Which one is rendered, is dependent from the given view state.
 */
struct LoginRegisterScreen: View {
    @Binding var viewState: ViewState
    var body: some View {
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
                .zIndex(-1)
            
            switch viewState {
            case .LOGIN:
                LoginView(viewState: $viewState)
                    .transition(.move(edge: .leading))
            case .REGISTER:
                RegisterView(viewState: $viewState)
                    .transition(.move(edge: .trailing))
            default:
                EmptyView()
            }
        }
    }
}

struct LoginRegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterScreen(viewState: .constant(ViewState.LOGIN))
    }
}
