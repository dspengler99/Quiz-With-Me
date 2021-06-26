//
//  PrimaryButton.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 20.05.21.
//

import SwiftUI

/**
 This is a custom style for the primary button in the game.
 */
struct PrimaryButton: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    var width: CGFloat
    var height: CGFloat

    /**
     This method returns the color for the primary button. The color changes when the button is pressed or disabled.
     
     -Parameter pressed: True means that the button is pressed, false means that the button is not pressed.
     - Parameter enabled: True means taht the button is enabled, false means that the button is disabled.
     - returns: The color for the button depending on the above explained parameters.
     */
    func getButtonColor(pressed: Bool, enabled: Bool) -> Color {
        if pressed {
            return Color.primaryButtonPressedBackground
        } else if !enabled {
            return Color.primaryButtonDisabledBackground
        } else {
            return Color.darkBlue
        }
    }
    
    /**
     Creates the design of the primary button.
     
     - Parameter configuration: The element that should be designed.
     - returns: A view with the element. In this case a button.
     */
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: width, minHeight: height)
            .background(getButtonColor(pressed: configuration.isPressed, enabled: isEnabled))
            .foregroundColor(.backgroundWhite)
            .cornerRadius(15)
    }
}
