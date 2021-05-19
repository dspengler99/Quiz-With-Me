//
//  Quiz_With_MeApp.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 11.05.21.
//

import SwiftUI
import Firebase

@main
struct Quiz_With_MeApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LoginRegisterScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
