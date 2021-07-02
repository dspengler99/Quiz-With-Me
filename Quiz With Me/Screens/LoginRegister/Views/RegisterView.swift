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
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
            ScrollView {
                ZStack {
                    VStack {
                        LogoImage()
                            .padding()
                        Spacer()
                        
                        Group {
                            Text("Erstelle dir ein neues Konto")
                                .h2()
                                .foregroundColor(Color.darkBlue)
                                .padding()
                            HStack {
                                Text("Nutzername")
                                    .h3()
                                    .foregroundColor(Color.darkBlue)
                                    .frame(width: 130, height: 30, alignment: .leading)
                                    .padding(.leading, 30)
                                TextField("Nutzername", text: $username)
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color.darkBlue)
                                    .multilineTextAlignment(.center)
                                    .frame(height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.primaryBlue, lineWidth: 2))
                                    .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.white))
                                    .padding(.trailing, 30)
                            }
                            .alert(isPresented: $usernameInUse) {
                                Alert(title: Text("Nutzername bereits vergeben"), message: Text("Der von dir gewählte Nutzername ist bereits vergeben."), dismissButton: .default(Text("Ok")))
                            }
                            HStack {
                                Text("E-Mail")
                                    .h3()
                                    .foregroundColor(Color.darkBlue)
                                    .frame(width: 130, height: 30, alignment: .leading)
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
                            HStack {
                                Text("Paswort")
                                    .h3()
                                    .foregroundColor(Color.darkBlue)
                                    .frame(width: 130, height: 30, alignment: .leading)
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
                            HStack {
                                Text("Passwort wiederholen")
                                    .h3()
                                    .foregroundColor(Color.darkBlue)
                                    .frame(width: 130, height: 50, alignment: .leading)
                                    .padding(.leading, 30)
                                Spacer()
                                SecureField("Passwort wiederholen", text: $repeatedPassword)
                                    .foregroundColor(Color.darkBlue)
                                    .multilineTextAlignment(.center)
                                    .frame(height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.primaryBlue, lineWidth: 2))
                                    .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.white))
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
                                    .h3()
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .foregroundColor(Color.backgroundWhite)
                            }
                            .buttonStyle(PrimaryButton(width: 300, height: 50))
                            .shadow(radius: 10)
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
                                .h3()
                                .frame(width: 200, height: 50, alignment: .center)
                                .foregroundColor(Color.backgroundWhite)
                        }
                        .shadow(radius: 10)
                        .buttonStyle(PrimaryButton(width: 200, height: 50))
                        .padding()
                    }
                }
            }
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewState: .constant(ViewState.REGISTER))
    }
}
