//
//  OverviewView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 22.05.21.
//

import SwiftUI

struct OverviewView: View {
    var body: some View {
        ZStack {
            Color.whiteBackground
            VStack {
                Text("Spielübersicht")
                    .underline()
                    .font(.title)
                    .foregroundColor(Color.primaryButtonDefaultBackground)
                    .padding(.bottom, 40)
                Group {
                    HStack {
                        Text("Du")
                            .underline()
                            .foregroundColor(Color.primaryButtonDefaultBackground)
                        Spacer()
                    }
                    .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    HStack {
                        Text("Aktueller Fortschritt:")
                        Spacer()
                        Text("3/5")
                    }
                    .padding(.bottom, 5)
                    HStack {
                        Text("Richtige Antworten:")
                        Spacer()
                        Text("2/5")
                    }
                    .padding(.bottom, 5)
                    HStack {
                        Text("Punkte:")
                        Spacer()
                        Text("20")
                    }
                }
                Divider()
                Group {
                    HStack {
                        Text("Gegner xyz")
                            .underline()
                            .foregroundColor(Color.primaryButtonDefaultBackground)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    HStack {
                        Text("Aktueller Fortschritt:")
                        Spacer()
                        Text("3/5")
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
