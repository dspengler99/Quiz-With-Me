//
//  QuestionButton.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import SwiftUI

/**
 This button style is used to display the answers of the question.
 */
struct QuestionButton: ButtonStyle {
    var width: CGFloat
    var height: CGFloat
    var fontSize: CGFloat

    /**
     Creates the design for the question button.
     
     - Parameter configuration: The element that should be designed.
     - returns: A view with the designed element. In this case this is a button.
     */
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: width, maxWidth: width, minHeight: height, maxHeight: height)
            .font(.system(size: fontSize))
            .foregroundColor(.white)
    }
}
