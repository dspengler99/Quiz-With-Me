//
//  LoginView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 13.05.21.
//

import SwiftUI
import Firebase

/**
 This view renders the login-screen with all needed input fields for the app.
 
 The environment object will be set, when the user clicks on signin.
 */
struct LoginView: View {
    @EnvironmentObject var quizUserWrapper: QuizUserWrapper
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    // Needed to handle the shown View
    @Binding var viewState: ViewState
    
    var body: some View {
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
            ScrollView {
                
                    VStack {
                        LogoImage()
                            .padding()
                        Spacer()
                        Group {
                            Text("Melde dich mit deinem Konto an!")
                                .h2()
                                .foregroundColor(Color.darkBlue)
                                .padding()
                            HStack {
                                Text("E-Mail")
                                    .h3()
                                    .frame(width: 100, alignment: .leading)
                                    .foregroundColor(Color.darkBlue)
                                    .padding(.leading, 30)
                                TextField("E-Mail", text: $email)
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color.darkBlue)
                                    .multilineTextAlignment(.center)
                                    .frame(height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.primaryBlue, lineWidth: 2))
                                    .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.white))
                                    .padding(.trailing, 30)
                            }
                                .padding(.top, 20)
                            HStack {
                                Text("Passwort")
                                    .h3()
                                    .frame(width: 100, alignment: .leading)
                                    .foregroundColor(Color.darkBlue)
                                    .padding(.leading, 30)
                                SecureField("Passwort", text: $password)
                                    .foregroundColor(Color.darkBlue)
                                    .multilineTextAlignment(.center)
                                    .frame(height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.primaryBlue, lineWidth: 2))
                                    .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.white))
                                    .padding(.trailing, 30)
                            }
                            Button("Anmelden") {
                                AuthenticationManager.shared.loginWith(email: email, and: password) { result, error in
                                    if let error = error {
                                        errorMessage = error.localizedDescription
                                        showAlert = true
                                    } else {
                                        if let uid = Auth.auth().currentUser?.uid {
                                            _ = DataManager.shared.getUser(uid: uid).done { response in
                                                if response != nil {
                                                    quizUserWrapper.quizUser = response!
                                                    withAnimation {
                                                        viewState = .HOME
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .buttonStyle(PrimaryButton(width: 300, height: 50))
                            .shadow(radius: 10)
                            .padding(25)
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Fehler"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                            }
                        }
                        Spacer()
                        Text("Noch kein Konto?")
                            .h3()
                            .foregroundColor(Color.darkBlue)
                            .padding(.top, 30)
                        Button("Jetzt Konto erstellen") {
                            withAnimation {
                                viewState = .REGISTER
                            }
                        }
                        .buttonStyle(PrimaryButton(width: 200, height: 50))
                        .shadow(radius: 10)
                        .padding()
                    }
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewState: .constant(ViewState.LOGIN))
    }
}
