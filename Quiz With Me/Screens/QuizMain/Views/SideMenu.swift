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
                ZStack {
                    List {
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.gameGreen)
                            Text("Mein Profil")
                                .h3()
                                .frame(width: 120, height: 50, alignment: .leading)
                                .foregroundColor(.darkBlue)
                                .onTapGesture {
                                    viewState = .PROFILE
                            }
                        }
                        HStack {
                            Image(systemName: "arrow.down.left.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.gameRed)
                            Text("Abmelden")
                                .h3()
                                .frame(width: 120, height: 50, alignment: .leading)
                                .foregroundColor(.darkBlue)
                                .onTapGesture {
                                    if(AuthenticationManager.shared.signOut()) {
                                        viewState = .LOGIN
                                    }
                            }
                        }
                    }
                    .frame(width: 170)
                    .offset(x: menuToggled ? 0 : 170)
                    .colorMultiply(Color.accentYellow)
                    .animation(.default)
                }
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
