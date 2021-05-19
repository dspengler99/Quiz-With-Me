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

    // Needed for handling the shown view
    @Binding var viewState: ViewState
    
    var body: some View {
        ZStack {
            Color(CGColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0))
                .ignoresSafeArea()
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
                        Button(action: {}) {
                            HStack {
                                Text("Konto erstellen")
                            }
                            .frame(maxWidth: 200)
                            .padding()
                            .font(.system(size: 15))
                            .background(Color(CGColor(red: 0.0, green: 0.46, blue: 0.74, alpha: 1.0)))
                            .foregroundColor(.white)
                        }
                        .padding(.top, 20)
                    }
                    Spacer()
                    Text("Du hast bereits ein Konto?")
                        .font(.system(size: 12))
                        .padding(.top, 30)
                    Button(action: {
                        viewState = .LOGIN
                    }) {
                        HStack {
                            Text("Jetzt anmelden")
                        }
                        .frame(maxWidth: 200)
                        .padding()
                        .font(.system(size: 12))
                        .background(Color(CGColor(red: 0.0, green: 0.46, blue: 0.74, alpha: 1.0)))
                        .foregroundColor(.white)
                    }
                    .padding(.bottom, 30)
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
