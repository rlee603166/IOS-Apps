//
//  ContentView.swift
//  Journal
//
//  Created by Ryan Lee on 7/26/24.
//

import SwiftUI
import CoreData

struct TextView: View {
    
    var item: Item
    
    @AppStorage("colorScheme") var colorScheme = 0
    
    
    var body: some View {
        
        VStack {
            Text(item.title ?? "No title found")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.vertical)
            
            Text("Workout Summary")
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Text("Muscle workedout: \(MuscleCategoryType(rawValue: Int(item.muscle)).description())")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("Workout quality: \(QualityCategoryType(rawValue: Int(item.quality)).description())")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()            
            Text("Weight on \(item.timestamp!, formatter: itemFormatter): \(item.weight) lbs")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("Calories burned: \(item.calories)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("Max heart rate: \(item.heartrate)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Spacer()
            Text("Workout notes: ")
                .font(.title2)
            
            ScrollView {
                Text(item.text ?? "No notes")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            Spacer()
        }
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct ContentView: View {
    
    @AppStorage("colorScheme") var colorScheme = 0
    
    var body: some View {
        
        TabView {
            ItemListView()
                .tabItem {
                    Label(TabType.workouts.title(), systemImage: TabType.workouts.image())
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
        .preferredColorScheme(colorScheme == 1 ? .light : colorScheme == 2 ? .dark : nil)
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
