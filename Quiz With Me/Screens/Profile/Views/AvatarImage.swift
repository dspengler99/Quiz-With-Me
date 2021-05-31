//
//  AvatarImage.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

struct AvatarImage: View {
     var body: some View {
         VStack {
             Image("fallback-image")
                 .resizable()
                 .frame(width: .infinity, height: 270)
         }
     }
 }

 struct AvatarImage_Previews: PreviewProvider {
     static var previews: some View {
         AvatarImage()
     }
 }
