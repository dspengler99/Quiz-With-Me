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
            if let quizUser = quizUserWrapper.quizUser, !isLoading {
                VStack(alignment: .leading) {
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 150, alignment: .top)
                            .foregroundColor(.blue)
                        VStack {
                            HStack {
                                Text(quizUser.username)
                                    .font(.title)
                                Spacer()
                            }
                            HStack {
                                Text(email)
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    AvatarImage()
                    ProfileDetailView(totalGames: quizUser.totalGames, wonGames: quizUser.wonGames)
                        .padding(.top, 40)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
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
     }
 }
