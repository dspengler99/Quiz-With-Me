//
//  GameOverviewScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

struct GameOverviewScreen: View {
    @Binding var viewState: ViewState
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                OverviewView(viewState: $viewState)
            }
        }
    }
}

struct GameOverviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameOverviewScreen(viewState: .constant(ViewState.HOME))
    }
}
