//
//  SettingsView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/9/24.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("colorScheme") var colorScheme = 0
    @AppStorage("largeFont") var largeFont = false
    @AppStorage("boldFont") var boldFont = false
    @AppStorage("inlineNotes") var inlineNotes = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Appearance") {
                    Picker(selection: $colorScheme, label: Text("Appearance")) {
                        Text("System").tag(0)
                        Text("Light").tag(1)
                        Text("Dark").tag(2)
                    }
                    .pickerStyle(.menu)
                }
                Section("Text") {
                    Toggle("Enlarge", isOn: $largeFont)
                    Toggle("Bold", isOn: $boldFont)
                }
                Section("Columns in profile") {
                    Toggle("Desription", isOn: $inlineNotes)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
