//
//  LoginView.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 13.05.21.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    // Needed to handle the shown View
    @Binding var viewState: ViewState
    
    var body: some View {
        ZStack {
            Color(CGColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0))
                .ignoresSafeArea()
            ScrollView {
            ScrollView {
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
                                .background(Color.white)
                                    .padding(.trailing, 30)
                            }
                            .padding(.top, 20)
                            HStack {
                                Text("Passwort")
                                    .frame(width: 100)
                                    .padding()
                                SecureField("Passwort", text: $password)
                                    .background(Color.white)
                                    .padding(.trailing, 30)
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Text("Anmelden")
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
                        Text("Noch kein Konto?")
                            .font(.system(size: 15))
                            .padding(.top, 30)
                        Button(action: {
                            viewState = .REGISTER
                        }) {
                            HStack {
                                Text("Konto jetzt erstellen")
                            }
                            .frame(maxWidth: 150)
                                .padding()
                            .font(.system(size: 15))
                                .background(Color(CGColor(red: 0.0, green: 0.46, blue: 0.74, alpha: 1.0)))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 30)
                    }
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
