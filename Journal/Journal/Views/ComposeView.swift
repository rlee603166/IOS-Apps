//
//  ComposeView.swift
//  Journal
//
//  Created by Ryan Lee on 7/26/24.
//

import SwiftUI

struct ComposeView: View {
    
    @AppStorage("colorScheme") var colorScheme = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var itemTitle: String = ""
    @State var itemText: String = ""
    @State var muscle: MuscleCategoryType = .abs
    @State var heartrate: String = ""
    @State var quality: QualityCategoryType = .no_opinion
    @State var calories: String = ""
    @State var curr_weight: String = ""
    
    @State private var isAlertPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Title")) {
                        TextField("Enter Workout Title", text: $itemTitle)
                    }
                    
                    Section(header: Text("Muscle")) {
                        Picker("Muscle Type", selection: $muscle) {
                            ForEach(MuscleCategoryType.allCases, id: \.self) { cat in
                                HStack {
                                    Text(cat.description())
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Workout Quality")) {
                        Picker("Quality", selection: $quality) {
                            ForEach(QualityCategoryType.allCases, id: \.self) { cat in
                                HStack {
                                    Text(cat.description())
                                }	
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section(header: Text("Current Weight")) {
                        TextField("110", text: $curr_weight)
                    }
                    
                    Section(header: Text("Calores Burned")) {
                        TextField("50", text: $calories)
                    }
                    
                    Section(header: Text("Max Heart rate")) {
                        TextField("150", text: $heartrate)
                    }
                    
                    Section(header: Text("Workout Notes")) {
                        TextEditor(text: $itemText)
                            .frame(height: 250)
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 64)
                        .frame(width: 64, height: 32)
                        .foregroundColor(.accentColor)
                    Button(action: {
                        if itemTitle.isEmpty || itemText.isEmpty || heartrate.isEmpty || calories.isEmpty || curr_weight.isEmpty {
                            isAlertPresented = true
                        } else {
                            addItem()
                            dismiss()
                        }
                    }) {
                        Text("Save")
                            .foregroundColor(colorScheme == 1 ? .white : colorScheme == 2 ? .black : .primary)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                Spacer()
            }
            .alert(isPresented: $isAlertPresented) {
                Alert(
                    title: Text("Incomplete Form"),
                    message: Text("Please fill in all fields."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = itemTitle
            newItem.text = itemText
            
            // New item attributes
            newItem.calories = Int16(calories) ?? 0
            newItem.weight = Int16(curr_weight) ?? 0
            newItem.quality = Int16(quality.rawValue)
            newItem.heartrate = Int16(heartrate) ?? 0
            newItem.muscle = Int16(muscle.rawValue)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ComposeView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
