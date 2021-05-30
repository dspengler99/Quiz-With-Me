//
//  MenuContentListView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 27.05.21.
//

import SwiftUI

struct SideMenu: View {
    @Binding var menuToggled: Bool
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
                    NavigationLink(destination: EmptyView()) {
                        Text("Mein Profil")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Mein Freunde")
                    }
                }
                .frame(width: 250)
                .offset(x: menuToggled ? 0 : 250)
                .animation(.default)
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct MenuContentListView_Previews: PreviewProvider {
    @State static var menuToggled = false
    static var previews: some View {
        SideMenu(menuToggled: $menuToggled)
    }
}
