//
//  BackButton.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 06.06.21.
//

import SwiftUI

struct BackButton: View {
    @Binding var viewState: ViewState
    var changeView: ViewState
    var color: Color
    
    var body: some View {
        Button(action: {
            withAnimation {
                viewState = changeView
            }
        }) {
            Image(systemName: "arrow.backward.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(color)
        }
    }
}

/*
struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
*/
