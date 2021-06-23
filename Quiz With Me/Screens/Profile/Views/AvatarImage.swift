//
//  AvatarImage.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

struct AvatarImage: View {
    var userShortname: String
    
    var body: some View {
        VStack {
            Text(userShortname)
                .frame(width: 200, height: 200, alignment: .center)
                .font(.system(size: 80))
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 20)
                .overlay(Circle().stroke(Color.white, lineWidth: 10))
        }
    }
}

struct AvatarImage_Previews: PreviewProvider {
    static var previews: some View {
        AvatarImage(userShortname: "Te")
    }
}
