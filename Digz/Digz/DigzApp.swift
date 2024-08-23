//
//  DigzApp.swift
//  Digz
//
//  Created by Ryan Lee on 7/31/24.
//

import SwiftUI

@main
struct DigzApp: App {
    
    let locationVM = LocationVM()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(locationVM)
        }
    }
}
