//
//  ProfileScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

struct ProfileScreen: View {
    @Binding var viewState: ViewState
    @EnvironmentObject var quizUserWrapper: QuizUserWrapper
    @State private var isLoading = true
    @State private var email = AuthenticationManager.shared.getEMail()
    
    var body: some View {
        
        Group {
            EmptyView()
            if let quizUser = quizUserWrapper.quizUser, !isLoading {
                ZStack {
                    Color.backgroundWhite
                        .ignoresSafeArea()
                    VStack() {
                        ZStack {
                            BackgroundView()
                            VStack {
                                HStack() {
                                    BackButton(viewState: $viewState, changeView: .HOME, color: Color.backgroundWhite)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                            AvatarImage(userShortname: String(quizUser.username.prefix(2)))
                                .offset(y: 15)
                                .padding(.top, 15)
                        }
                        ProfileDetailView(name: quizUser.username, email: email, totalGames: quizUser.totalGames, wonGames: quizUser.wonGames)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            guard let quizUser = quizUserWrapper.quizUser else {
                return
            }
            _ = DataManager.shared.getUser(uid: quizUser.userID).done { response in
                guard let refreshedUser = response else {
                    return
                }
                quizUserWrapper.quizUser = refreshedUser
                isLoading = false
            }
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(viewState: .constant(.PROFILE))
            .environmentObject(QuizUserWrapper())
    }
}
