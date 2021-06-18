//
//  QuestionButton.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import SwiftUI

struct QuestionButton: ButtonStyle {
    var width: CGFloat
    var height: CGFloat
    var fontSize: CGFloat

    /*
    func getButtonColor(pressed: Bool, enabled: Bool) -> Color {
        if pressed {
            return Color.primaryButtonPressedBackground
        } else if !enabled {
            return Color.primaryButtonDisabledBackground
        } else {
            return Color.primaryButtonDefaultBackground
        }
    }
    */
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: width, maxWidth: width, minHeight: height, maxHeight: height)
            .font(.system(size: fontSize))
            .foregroundColor(.white)
    }
}
