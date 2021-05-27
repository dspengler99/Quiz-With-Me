//
//  RegisterView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 19.05.21.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeatedPassword: String = ""
    @State private var showAlert = false
    
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
                        .background(Color.white)
                            .padding(.trailing, 30)
                    }
                    HStack {
                        Text("E-Mail")
                            .frame(width: 100)
                            .padding()
                        TextField("E-Mail", text: $email)
                        .background(Color.white)
                            .padding(.trailing, 30)
                    }
                    HStack {
                        Text("Paswort")
                            .frame(width: 100)
                            .padding()
                        SecureField("Passwort", text: $password)
                        .background(Color.white)
                            .padding(.trailing, 30)
                    }
                    HStack {
                        Text("Passwort wiederholen")
                            .frame(width: 100)
                            .padding()
                        Spacer()
                        SecureField("Passwort wiederholen", text: $repeatedPassword)
                        .background(Color.white)
                        .padding(.trailing, 30)
                    }
                    Button("Konto erstellen") {
                        AuthenticationManager.shared.signupWith(username: username, email: email, and: password) { result, error in
                            if let _ = error {
                                showAlert = true
                            }
                        }
                    }
                    .buttonStyle(PrimaryButton(width: 300, height: 50, fontSize: 20))
                    .padding()
                    .disabled((username == "" && email == "" && password == "" && repeatedPassword == "") || password != repeatedPassword || password.count < 8)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Fehler"), message: Text("Ein Fehler ist aufgetreten."), dismissButton: .default(Text("OK")))
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
