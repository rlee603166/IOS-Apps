//
//  MapView.swift
//  FindMe
//
//  Created by Arthur Roolfs on 7/1/24.
//

import SwiftUI
import MapKit

let kLocation = CLLocation(latitude: 43.1593,longitude: -77.6068)

struct MapView: View {
    
    @EnvironmentObject var locationVM: LocationVM
    var apartment: Apartment
    let dist = 1000.0
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default center
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: .constant(region), showsUserLocation: true)
                .onAppear {
                    geocodeAndUpdateRegion(for: apartment.address ?? "755 Library Rd, Rochester")
                }
        }
        .ignoresSafeArea(.all)
    }
    private func geocodeAndUpdateRegion(for address: String) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) { placemarks, error in
                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                } else if let placemark = placemarks?.first,
                          let location = placemark.location {
                    // Update the map region
                    self.region = MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                    )
                } else {
                    print("No location found for address.")
                }
            }
        }
}
