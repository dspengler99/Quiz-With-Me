//
//  noGameCard.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 25.06.21.
//

import SwiftUI

struct NoGameCard: View {
    var body: some View {
        ZStack {
            Color.accentYellow
            VStack(alignment: .center) {
                Text("Du hast keine aktiven Spiele. Starte jetzt ein Neues.")
                    .h2()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.darkBlue)
                    .padding(.bottom, 15)
                Image(systemName: "tortoise.fill")
                    .resizable()
                    .frame(width: 70, height: 50, alignment: .center)
                    .foregroundColor(Color.darkBlue)
            }
            .padding()
        }
        .frame(width: 350, height: 200)
        .cornerRadius(25)
        .shadow(radius: 7)
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
    }
}

struct noGameCard_Previews: PreviewProvider {
    static var previews: some View {
        NoGameCard()
    }
}
