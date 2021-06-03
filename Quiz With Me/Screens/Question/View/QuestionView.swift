//
//  QuestionView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 350, height: 200)
                    .cornerRadius(25)
                
                Text("Question")
                    .foregroundColor(.white)
            }
            
            Text("Frage 1/5")
                .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.primaryButtonDefaultBackground)
            
            HStack {
                Button("Antwort 1") {
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .shadow(radius: 20)
                .padding(10)
                
                Button("Antwort 2") {
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .shadow(radius: 20)
                .padding(10)
            }
            
            HStack {
                Button("Antwort 3") {
                    
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .shadow(radius: 20)
                .padding(10)
                
                Button("Antwort 4") {
                    
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .shadow(radius: 20)
                .padding(10)
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
