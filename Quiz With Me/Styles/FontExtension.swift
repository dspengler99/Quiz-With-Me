//
//  FontExtension.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 25.06.21.
//

import SwiftUI

extension Text {
    func h1() -> some View {
        self.font(.custom("Nunito-Regular", size: 26))
    }
    func h1_bold() -> some View {
        self.font(.custom("Nunito-Bold", size: 26))
    }
    func h1_underline() -> some View {
        self.font(.custom("Nunito-Bold", size: 26))
            .underline()
    }
    func h2() -> some View {
        self.font(.custom("Nunito-Regular", size: 22))
    }
    func h2_bold() -> some View {
        self.font(.custom("Nunito-SemiBold", size: 22))
    }
    func h2_underline() -> some View {
        self.font(.custom("Nunito-SemiBold", size: 22))
            .underline()
    }
    func h3() -> some View {
        self.font(.custom("Nunito-Regular", size: 18))
    }
    func avatarFont() -> some View {
        self.font(.custom("Nunito-SemiBold", size: 80))
    }
}
