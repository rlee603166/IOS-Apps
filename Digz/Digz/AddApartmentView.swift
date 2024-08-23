//
//  ApartmentView.swift
//  Digz
//
//  Created by Ryan Lee on 7/31/24.
//

import SwiftUI

struct AddApartmentView: View {
    
    @EnvironmentObject private var locationVM: LocationVM
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var listing: String = ""
    @State private var rent: String = ""
    @State private var sqft: String = ""
    @State private var address: String = ""
    @State private var phone: String = ""
    @State private var notes: String = ""
    @State private var lat: Double = 37.7749
    @State private var long: Double = -122.4194
    @State private var isPresenting: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("listing")) {
                        TextField("Enter listing" , text: $listing)
                    }
                    Section(header: Text("Rent")) {
                        TextField("Enter rent amount" , text: $rent)
                    }
                    Section(header: Text("Square Footage")) {
                        TextField("Enter sqft amount" , text: $sqft)
                    }
                    
                    Section(header: Text("Phone")) {
                        TextField("Enter phone number" , text: $phone)
                    }
                    
                    Button("Find apartment") {
                        isPresenting = true
                    }
                    Text(address)
                    
                    Section(header: Text("Notes")) {
                        TextField("Enter notes" , text: $notes)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .frame(minHeight: 200, alignment: .top)
                            .padding(.top, 5)
                    }
                }
                .navigationTitle(Text("Add Apartment"))
                .sheet(isPresented: $isPresenting) {
                    GeoView(lat: $lat, long: $long, address: $address, isPresenting: $isPresenting)
                        .environment(\.managedObjectContext, viewContext)
                }
                
                
                Button("Save") {
                    addApartment()
                    locationVM.stop()
                    dismiss()
                }
            }
            .onAppear() {
                locationVM.start()
            }
        }
    }
    
    private func addApartment() {
        withAnimation {
            let newApt = Apartment(context: viewContext)
            newApt.timestamp = Date()
            newApt.title = listing
            newApt.rent = Double(rent) ?? 0.0
            newApt.sqft = Int16(sqft) ?? 0
            newApt.address = address
            newApt.phone = phone
            newApt.notes = notes
            newApt.latitude = locationVM.location?.coordinate.latitude ?? 0.0
            newApt.longitude = locationVM.location?.coordinate.longitude ?? 0.0
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
    AddApartmentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(LocationVM())
}
