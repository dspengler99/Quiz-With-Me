//
//  MenuButton.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct MenuButton: View {
    @Binding var menuToggled: Bool
    
    func toggleMenu() {
        menuToggled.toggle()
    }
    
    var body: some View {
        Button(action: {
            toggleMenu()
        }) {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    @State static var menuToggled = false
    static var previews: some View {
        MenuButton(menuToggled: $menuToggled)
    }
}
