//
//  BackgroundView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 05.06.21.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: .infinity, height: 220)
                    .cornerRadius(20)
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
