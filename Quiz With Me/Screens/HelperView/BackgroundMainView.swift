//
//  BackgroundMainView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 25.06.21.
//

import SwiftUI

struct BackgroundMainView: View {
    var body: some View {
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
            VStack {
                Rectangle()
                    .fill(Color.primaryBlue)
                    .frame(width: UIScreen.main.bounds.width, height: 150)
                    .cornerRadius(25)
                    .offset(x: 0, y: -20)
                    .ignoresSafeArea(edges: .top)
                Spacer()
            }
        }
    }
}

struct BackgroundMainView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundMainView()
    }
}
