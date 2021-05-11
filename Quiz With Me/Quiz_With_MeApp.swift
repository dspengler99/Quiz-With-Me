//
//  Quiz_With_MeApp.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 11.05.21.
//

import SwiftUI

@main
struct Quiz_With_MeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
