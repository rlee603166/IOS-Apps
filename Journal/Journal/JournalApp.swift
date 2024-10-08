//
//  JournalApp.swift
//  Journal
//
//  Created by Ryan Lee on 7/26/24.
//

import SwiftUI

@main
struct JournalApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
