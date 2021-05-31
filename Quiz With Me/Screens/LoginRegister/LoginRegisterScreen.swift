//
//  LoginRegisterScreen.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 19.05.21.
//

import SwiftUI

struct LoginRegisterScreen: View {
    @Binding var viewState: ViewState
    var body: some View {
        ZStack {
            Color(CGColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0))
                .ignoresSafeArea()
                .zIndex(-1)
            
            switch viewState {
            case .LOGIN:
                LoginView(viewState: $viewState)
                    .transition(.move(edge: .leading))
            case .REGISTER:
                RegisterView(viewState: $viewState)
                    .transition(.move(edge: .trailing))
            }
        }
    }
}

struct LoginRegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterScreen(viewState: .constant(ViewState.LOGIN))
    }
}
