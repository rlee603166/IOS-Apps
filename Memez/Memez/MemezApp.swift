//
//  MemezApp.swift
//  Memez
//
//  Created by Ryan Lee on 7/19/24.
//

import SwiftUI

@main
struct MemezApp: App {
    
    let generator = Generator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(generator)
        }
    }
}
