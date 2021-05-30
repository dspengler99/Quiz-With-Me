//
//  LogoImageWhite.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct LogoImageWhite: View {
     var body: some View {
         Image(decorative: "QuizWithMeQhite")
             .resizable()
            .frame(width: 120, height: 120)
     }
 }

struct LogoImageWhite_Previews: PreviewProvider {
    static var previews: some View {
        LogoImageWhite()
    }
}
