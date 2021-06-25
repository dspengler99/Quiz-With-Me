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
        ScrollView {
            ZStack {
                Color.backgroundWhite
                    .ignoresSafeArea()
                VStack {
                    LogoImage()
                    Spacer()
                    Group {
                        Text("Melde dich mit deinem Konto an!")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                        HStack {
                            Text("E-Mail")
                                .frame(width: 100)
                                .padding()
                            TextField("E-Mail", text: $email)
                                .background(Color.backgroundWhite)
                                .padding(.trailing, 30)
                        }
                            .padding(.top, 20)
                        HStack {
                            Text("Passwort")
                                .frame(width: 100)
                                .padding()
                            SecureField("Passwort", text: $password)
                                .background(Color.backgroundWhite)
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
                        .padding()
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Fehler"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                    Spacer()
                    Text("Noch kein Konto?")
                        .font(.system(size: 15))
                        .padding(.top, 30)
                    Button("Jetzt Konto erstellen") {
                        withAnimation {
                            viewState = .REGISTER
                        }
                    }
                    .buttonStyle(PrimaryButton(width: 200, height: 50))
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
