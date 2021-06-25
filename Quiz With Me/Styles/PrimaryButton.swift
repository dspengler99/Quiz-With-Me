//
//  PrimaryButton.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 20.05.21.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    var width: CGFloat
    var height: CGFloat

    func getButtonColor(pressed: Bool, enabled: Bool) -> Color {
        if pressed {
            return Color.primaryButtonPressedBackground
        } else if !enabled {
            return Color.primaryButtonDisabledBackground
        } else {
            return Color.darkBlue
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: width, minHeight: height)
            .background(getButtonColor(pressed: configuration.isPressed, enabled: isEnabled))
            .foregroundColor(.backgroundWhite)
            .cornerRadius(15)
    }
}
