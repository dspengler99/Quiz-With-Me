//
//  BackgroundView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 05.06.21.
//

import SwiftUI

/**
 This view is used to represent the background in most views.
 */
struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
            VStack {
                Rectangle()
                    .fill(Color.primaryBlue)
                    .frame(width: UIScreen.main.bounds.width, height: 260)
                    .cornerRadius(25)
                    .offset(x: 0, y: -20)
                    .ignoresSafeArea(edges: .top)
                Spacer()
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
