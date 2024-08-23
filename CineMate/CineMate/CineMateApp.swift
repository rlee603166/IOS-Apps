//
//  CineMateApp.swift
//  CineMate
//
//  Created by Ryan Lee on 8/7/24.
//

import SwiftUI

@main
struct CineMateApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ImageHelper())
                .environmentObject(MovieHelper())
                .environmentObject(QueueManager())
        }
    }
}
