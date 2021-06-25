//
//  RegisterView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 19.05.21.
//

import SwiftUI
import Firebase

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
                        .font(.title2)
                        .padding()
                    HStack {
                        Text("Nutzername")
                            .frame(width: 100)
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
                            .frame(width: 100)
                            .padding()
                        TextField("E-Mail", text: $email)
                        .background(Color.backgroundWhite)
                            .padding(.trailing, 30)
                    }
                    HStack {
                        Text("Paswort")
                            .frame(width: 100)
                            .padding()
                        SecureField("Passwort", text: $password)
                        .background(Color.backgroundWhite)
                            .padding(.trailing, 30)
                    }
                    HStack {
                        Text("Passwort wiederholen")
                            .frame(width: 100)
                            .padding()
                        Spacer()
                        SecureField("Passwort wiederholen", text: $repeatedPassword)
                        .background(Color.backgroundWhite)
                        .padding(.trailing, 30)
                    }
                    Button("Konto erstellen") {
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
                    }
                    .buttonStyle(PrimaryButton(width: 300, height: 50, fontSize: 20))
                    .padding()
                    .disabled((username == "" && email == "" && password == "" && repeatedPassword == "") || password != repeatedPassword || password.count < 8)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Fehler"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer()
                Text("Du hast bereits ein Konto?")
                    .font(.system(size: 12))
                    .padding(.top, 30)
                Button("Jetzt anmelden") {
                    withAnimation {
                        viewState = .LOGIN
                    }
                }
                .buttonStyle(PrimaryButton(width: 200, height: 50, fontSize: 20))
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
