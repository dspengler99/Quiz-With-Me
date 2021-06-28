//
//  QuestionScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import SwiftUI

/**
 This screen represents the question and loads all needed information for it.
 */
struct QuestionScreen: View {
    @Binding var viewState: ViewState
    @Binding var selectedGame: String
    var body: some View {
        ZStack {
            BackgroundView()
            QuestionView(viewState: $viewState, selectedGame: $selectedGame)
        }
    }
}


struct QuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuestionScreen(viewState: .constant(ViewState.GAME), selectedGame: .constant("z2tmdhFW2vbRe9Qhxvrd"))
    }
}

