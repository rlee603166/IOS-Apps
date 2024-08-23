//
//  GeoView.swift
//  Digz
//
//  Created by Ryan Lee on 8/2/24.
//

import SwiftUI
import MapKit
import CoreLocation



struct GeoView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var lat: Double
    @Binding var long: Double
    
    @Binding var isPresenting: Bool
    
    @State private var region: MKCoordinateRegion
    @Binding private var address: String
    @State var title = "Apartment"
    
    init(lat: Binding<Double>, long: Binding<Double>, address: Binding<String>, title: String = "Apartment", isPresenting: Binding<Bool>) {
        self._lat = lat
        self._long = long
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat.wrappedValue, longitude: long.wrappedValue),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        self._address = address
        self.title = title
        self._isPresenting = isPresenting
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding()
                        TextField("search", text: $address, onCommit: {
                            geocodeAddress(address: address)
                        })
                        
                    }
                    .background()
                    .cornerRadius(17)
                    .padding()
                }
                .onAppear {
                    geocodeAddress(address: address)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        isPresenting = false
                    }) {
                        VStack {
                            Text("Cancel")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        isPresenting = false
                    }) {
                        VStack {
                            Text("Save")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    .disabled(address.isEmpty)
                }
            }
        }
    }


    
    private func geocodeAddress(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first,
                      let location = placemark.location {
                self.region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                )
            }
        }
    }
}

struct GeoView_Previews: PreviewProvider {
    static var previews: some View {
        GeoView(lat: .constant(37.7749), long: .constant(-122.4194), address: .constant(""), isPresenting: .constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
