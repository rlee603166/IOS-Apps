//
//  AddItemView.swift
//  Journal
//
//  Created by Ryan Lee on 8/6/24.
//

import SwiftUI

struct ItemListView: View {
    
    @AppStorage("largeFont") var largeFont = false
    @AppStorage("boldFont") var boldFont = false
    @AppStorage("inlineNotes") var inlineNotes = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        TextView(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(item.title!)
                                .font(largeFont ? .largeTitle : .headline)
                            Spacer()
                            if inlineNotes {
                                Text(item.text ?? "")
                                    .font(largeFont ? .body : .subheadline)
                            }
                            Spacer()
                            Text(item.timestamp!, formatter: itemFormatter)
                                .font(largeFont ? .body : .subheadline)
                            Spacer()
                        }
                        .frame(height: (inlineNotes ? 75 : 25))
                        .padding()
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .fontWeight(boldFont ? /*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/ : nil)
            .navigationTitle("Workout Journal 💪")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ComposeView().environment(\.managedObjectContext, viewContext)){
                        
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }



    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ItemListView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
