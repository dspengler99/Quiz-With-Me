//
//  RegisterView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 19.05.21.
//

import SwiftUI
import Firebase

/**
 This view renders all information for the registration process and includes checks for misstyped passwords.
 
 At the end of the process, the environment object will be set, atleast when the user clicks on the signup button.
 */
struct RegisterView: View {
    @EnvironmentObject var quizUserWrapper: QuizUserWrapper
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeatedPassword: String = ""
    @State private var showAlert = false
    @State private var usernameInUse = false
    @State private var errorMessage: String = ""
    
    // Needed for handling the shown view
    @Binding var viewState: ViewState
    
    var body: some View {
        ScrollView {
            VStack {
                LogoImage()
                Spacer()
                
                Group {
                    Text("Erstelle dir ein neues Konto")
                        .h2()
                        .foregroundColor(Color.darkBlue)
                        .padding()
                    HStack {
                        Text("Nutzername")
                            .h2()
                            .foregroundColor(Color.darkBlue)
                            .frame(width: 100, alignment: .leading)
                            .padding()
                        TextField("Nutzername", text: $username)
                        .background(Color.backgroundWhite)
                            .padding(.trailing, 30)
                    }
                    .alert(isPresented: $usernameInUse) {
                        Alert(title: Text("Nutzername bereits vergeben"), message: Text("Der von dir gewählte Nutzername ist bereits vergeben."), dismissButton: .default(Text("Ok")))
                    }
                    HStack {
                        Text("E-Mail")
                            .h2()
                            .foregroundColor(Color.darkBlue)
                            .frame(width: 100, alignment: .leading)
                            .padding()
                        TextField("E-Mail", text: $email)
                        .background(Color.backgroundWhite)
                            .padding(.trailing, 30)
                    }
                    HStack {
                        Text("Paswort")
                            .h2()
                            .foregroundColor(Color.darkBlue)
                            .frame(width: 100, alignment: .leading)
                            .padding()
                        SecureField("Passwort", text: $password)
                        .background(Color.backgroundWhite)
                            .padding(.trailing, 30)
                    }
                    HStack {
                        Text("Passwort wiederholen")
                            .h2()
                            .foregroundColor(Color.darkBlue)
                            .frame(width: 100, alignment: .leading)
                            .padding()
                        Spacer()
                        SecureField("Passwort wiederholen", text: $repeatedPassword)
                        .background(Color.backgroundWhite)
                        .padding(.trailing, 30)
                    }
                    Button(action: {
                        _ = DataManager.shared.usernameAlreadyExists(username: username).done { response in
                            guard response == false else {
                                usernameInUse = true
                                return
                            }
                            AuthenticationManager.shared.signupWith(username: username, email: email, and: password) { result, error in
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
                    }) {
                        Text("Konto erstellen")
                            .h2()
                            .frame(width: 300, height: 50, alignment: .center)
                            .foregroundColor(Color.backgroundWhite)
                    }
                    .buttonStyle(PrimaryButton(width: 300, height: 50))
                    .padding()
                    .disabled((username == "" && email == "" && password == "" && repeatedPassword == "") || password != repeatedPassword || password.count < 8)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Fehler"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer()
                Text("Du hast bereits ein Konto?")
                    .h3()
                    .foregroundColor(Color.darkBlue)
                    .padding(.top, 30)
                Button(action: {
                    withAnimation {
                        viewState = .LOGIN
                    }
                }) {
                    Text("Jetzt anmelden")
                        .h2()
                        .frame(width: 200, height: 50, alignment: .center)
                        .foregroundColor(Color.backgroundWhite)
                }
                .buttonStyle(PrimaryButton(width: 200, height: 50))
                .padding()
            }
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewState: .constant(ViewState.REGISTER))
    }
}
