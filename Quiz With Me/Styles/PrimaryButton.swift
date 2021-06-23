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
    var fontSize: CGFloat

    func getButtonColor(pressed: Bool, enabled: Bool) -> Color {
        if pressed {
            return Color.primaryButtonPressedBackground
        } else if !enabled {
            return Color.primaryButtonDisabledBackground
        } else {
            return Color.primaryButtonDefaultBackground
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: width, minHeight: height)
            .font(.system(size: fontSize))
            .background(getButtonColor(pressed: configuration.isPressed, enabled: isEnabled))
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}
