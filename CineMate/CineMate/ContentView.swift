//
//  ContentView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/7/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject private var queueManager: QueueManager
    
    @AppStorage("colorScheme") var colorScheme = 0
    
    @State private var isActionSheetShown = false
    @State private var goInfo = false
    @State private var liked: [Movie] = []
    
    var body: some View {
        
        ZStack {
            TabView {
                SwipeView(liked: $liked)
                    .tabItem {
                        Label(TabType.movies.title(), systemImage: TabType.movies.image())
                    }
                ProfileView(movies: liked)
                    .tabItem {
                        Label(TabType.profile.title(), systemImage: TabType.profile.image())
                    }
                SettingsView()
                    .tabItem {
                        Label(TabType.settings.title(), systemImage: TabType.settings.image())
                    }
                InfoView()
                    .tabItem {
                        Label(TabType.info.title(), systemImage: TabType.info.image())
                    }

            }
        }
        .preferredColorScheme(colorScheme == 1 ? .light : colorScheme == 2 ? .dark : nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MovieHelper())
            .environmentObject(QueueManager())
    }
}
