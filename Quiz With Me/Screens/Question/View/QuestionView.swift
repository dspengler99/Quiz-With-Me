//
//  QuestionView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import SwiftUI

struct QuestionView: View {
    @State var progress = 0
    @State var answerPicked = false
    
    var body: some View {
        let questions: [QuizQuestion] = [
            QuizQuestion(question: "Wie heißt das Betriebssystem von Apple für Smartphones?", answers: ["macOS", "iOS", "ipadOS", "watchOS"], rightAnswer: "iOS"),
            QuizQuestion(question: "Welche Farbe hat eine geöhnliche Banane", answers: ["grün", "blau", "orange", "gelb"], rightAnswer: "gelb"),
            QuizQuestion(question: "Wie ist das Wetter heute", answers: ["bewölkt", "regnerisch", "klar", "sonnig"], rightAnswer: "klar"),
            QuizQuestion(question: "Wie heißt das Betriebssystem von Apple für Smartphones?", answers: ["macOS", "iOS", "ipadOS", "watchOS"], rightAnswer: "iOS"),
            QuizQuestion(question: "Welche Farbe hat eine geöhnliche Banane", answers: ["grün", "blau", "orange", "gelb"], rightAnswer: "gelb")
        ]
        
        VStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 350, height: 200)
                .cornerRadius(25)
                .shadow(radius: 20)
                .overlay(Text(
                            questions[progress].question)
                            .foregroundColor(.blue)
                            .padding(40)
                            .multilineTextAlignment(.center),
                         alignment: .center)
            
            Text("Frage \(progress + 1)/5")
                .padding(10)
                .foregroundColor(Color.primaryButtonDefaultBackground)
            
            HStack {
                Button(questions[progress].answers[0]) {
                    answerPicked = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        progress += 1
                        answerPicked = false
                    }
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .background(answerPicked ? (questions[progress].checkAnswer(answer: questions[progress].answers[0]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                .cornerRadius(25)
                .shadow(radius: 20)
                .padding(10)
                .disabled(answerPicked)
                
                Button(questions[progress].answers[1]) {
                    answerPicked = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        progress += 1
                        answerPicked = false
                    }
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .background(answerPicked ? (questions[progress].checkAnswer(answer: questions[progress].answers[1]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                .cornerRadius(25)
                .shadow(radius: 20)
                .padding(10)
                .disabled(answerPicked)
            }
            
            HStack {
                Button(questions[progress].answers[2]) {
                    answerPicked = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        progress += 1
                        answerPicked = false
                    }
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .background(answerPicked ? (questions[progress].checkAnswer(answer: questions[progress].answers[2]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                .cornerRadius(25)
                .shadow(radius: 20)
                .padding(10)
                .disabled(answerPicked)
                
                Button(questions[progress].answers[3]) {
                    answerPicked = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        progress += 1
                        answerPicked = false
                    }
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .background(answerPicked ? (questions[progress].checkAnswer(answer: questions[progress].answers[3]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                .cornerRadius(25)
                .shadow(radius: 20)
                .padding(10)
                .disabled(answerPicked)
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
