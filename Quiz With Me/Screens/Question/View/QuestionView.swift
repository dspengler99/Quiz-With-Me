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
    @Binding var viewState: ViewState
    
    var body: some View {
        let questions: [QuizQuestion] = [
            QuizQuestion(answers: ["macOS", "iOS", "ipadOS", "watchOS"], question: "Wie heißt das Betriebssystem von Apple für Smartphones?", rightAnswer: "iOS"),
            QuizQuestion(answers: ["grün", "blau", "orange", "gelb"], question: "Welche Farbe hat eine geöhnliche Banane", rightAnswer: "gelb"),
            QuizQuestion(answers: ["bewölkt", "regnerisch", "klar", "sonnig"], question: "Wie ist das Wetter heute", rightAnswer: "klar"),
            QuizQuestion(answers: ["macOS", "iOS", "ipadOS", "watchOS"], question: "Wie heißt das Betriebssystem von Apple für Smartphones?", rightAnswer: "iOS"),
            QuizQuestion(answers: ["grün", "blau", "orange", "gelb"], question: "Welche Farbe hat eine geöhnliche Banane", rightAnswer: "gelb")
        ]
        
        VStack {
            HStack {
                BackButton(viewState: $viewState, changeView: .HOME)
                Spacer()
            }
            .padding()
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
                        if(progress < questions.count - 1) {
                            progress += 1
                            answerPicked = false
                        } else {
                            viewState = .GAMEOVERVIEW
                        }
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
                        if(progress < questions.count - 1) {
                            progress += 1
                            answerPicked = false
                        } else {
                            viewState = .GAMEOVERVIEW
                        }
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
                        if(progress < questions.count - 1) {
                            progress += 1
                            answerPicked = false
                        } else {
                            viewState = .GAMEOVERVIEW
                        }
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
                        if(progress < questions.count - 1) {
                            progress += 1
                            answerPicked = false
                        } else {
                            viewState = .GAMEOVERVIEW
                        }
                    }
                }
                .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                .background(answerPicked ? (questions[progress].checkAnswer(answer: questions[progress].answers[3]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                .cornerRadius(25)
                .shadow(radius: 20)
                .padding(10)
                .disabled(answerPicked)
            }
            Spacer()
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewState: .constant(ViewState.HOME))
    }
}
