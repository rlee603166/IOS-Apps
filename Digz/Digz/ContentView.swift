//
//  ContentView.swift
//  Digz
//
//  Created by Ryan Lee on 7/31/24.
//

import SwiftUI
import CoreData
import MapKit



struct ApartmentView: View {
    @EnvironmentObject var locationVM: LocationVM
    
    var apartment: Apartment
    
    let dist = 1000.0
    private var region: MKCoordinateRegion
    
    init(apartment: Apartment) {
        self.apartment = apartment
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: self.apartment.latitude, longitude: self.apartment.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                Text(apartment.title ?? "No title found")
                    .font(.largeTitle)
                
                HStack {
                    Text("\t\(Double(apartment.rent).formatted(.currency(code: "USD")))")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    Spacer()
                    Text(String(apartment.sqft) + " sqft")
                        .font(.subheadline)
                    Spacer()
                        .frame(width: 50)
                }
                Text("Address:")
                Text("\t\(apartment.address ?? "No address found")")
                
                Text("Phone:")
                Text("\t\(apartment.phone ?? "No phone number found")")
                
                Text("Notes")
                Text("\t\(apartment.notes ?? "No notes found")")
                
                Text("Map:")
                MapView(apartment: apartment)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Apartment")
    }
}


struct ContentView: View {
    
    @EnvironmentObject var locationVM: LocationVM
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Apartment.timestamp, ascending: true)],
        animation: .default
    )
    private var apartments: FetchedResults<Apartment>

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                List {
                    ForEach(apartments) { apt in
                        NavigationLink {
                            ApartmentView(apartment: apt)
                                .environmentObject(locationVM)
                        } label: {
                            HStack {
                                MapView(apartment: apt)
                                    .frame(width: 75, height: 75)
                                    .border(Color.black)
                                VStack(alignment: .leading) {
                                    Text(apt.title ?? "No listing found")
                                        .font(.headline)
                                    
                                    Text("\(Double(apt.rent).formatted(.currency(code: "USD")))")
                                        .font(.subheadline)
                                    
                                    HStack {
                                        Image(systemName: "square.split.2x2")
                                        Text(String(apt.sqft))
                                            .font(.subheadline)
                                    }
                                    Text(String(apt.latitude))
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteApartment)
                }
                .navigationTitle("Digz")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: 
                                        AddApartmentView()
                                .environment(\.managedObjectContext, viewContext)
                                .environmentObject(locationVM)
                        ){
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func deleteApartment(offsets: IndexSet) {
        withAnimation {
            offsets.map { apartments[$0] }.forEach(viewContext.delete)

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
    ContentView()
        .environmentObject(LocationVM())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
