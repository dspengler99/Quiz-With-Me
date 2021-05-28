//
//  FriendsList.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 27.05.21.
//

import SwiftUI

struct FriendsList: View {
    @State private var selectedTab = 0

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.primaryButtonDefaultBackground)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.primaryButtonDefaultBackground)], for: .normal)
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
        UITableViewCell.appearance().backgroundColor = UIColor(Color.white)
    }
    
    var body: some View {
        ZStack {
            Color(CGColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0))
                .ignoresSafeArea()
                .zIndex(-1)
            
            VStack {
                Text("Freunde")
                    .font(.largeTitle)
                Picker(selection: $selectedTab, label: Text("")) {
                    Text("Freunde").tag(0)
                    Text("Freundschaftsanfragen").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if selectedTab == 0 {
                    FriendsView()
                } else {
                    FriendRequestsView()
                }
                Spacer()
            }
        }
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList()
    }
}
