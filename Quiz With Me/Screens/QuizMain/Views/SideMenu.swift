//
//  SideMenu.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct SideMenu: View {
    @Binding var menuToggled: Bool
    @Binding var viewState: ViewState
    var body: some View {
        ZStack {
            GeometryReader {
                _ in EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(self.menuToggled ? 1 : 0)
            .animation(Animation.easeIn.delay(0.2))
            .onTapGesture {
                MenuButton(menuToggled: $menuToggled).toggleMenu()
            }
            HStack {
                Spacer()
                List {
                    Text("Mein Profil")
                        .onTapGesture {
                            viewState = .PROFILE
                        }
                    Text("Abmelden")
                        .onTapGesture {
                            if(AuthenticationManager.shared.signOut()) {
                                viewState = .LOGIN
                            }
                        }
                }
                .frame(width: 250)
                .offset(x: menuToggled ? 0 : 250)
                .animation(.default)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuContentListView_Previews: PreviewProvider {
    @State static var menuToggled = false
    static var previews: some View {
        SideMenu(menuToggled: $menuToggled, viewState: .constant(ViewState.LOGIN))
    }
}
