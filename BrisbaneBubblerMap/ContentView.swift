//
//  ContentView.swift
//  BrisbaneBubblerMap
//
//  Created by Brandon Bakker on 27/3/2023.
//

import SwiftUI
import MapKit

//struct ContentView: View {
//    @StateObject var locationManager = LocationManager()
//    @State private var region = MKCoordinateRegion()
//    @State var tracking:MapUserTrackingMode = .followWithHeading
//
//    var body: some View {
//        Map(
//            coordinateRegion: $region,
//            interactionModes: MapInteractionModes.all,
//            showsUserLocation: true,
//            userTrackingMode: $tracking
//        )
//            .onAppear {
//                if let userLocation = locationManager.userLocation {
//                    region = MKCoordinateRegion(
//                        center: userLocation.coordinate,
//                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                    )
//                }
//            }
//    }
//}

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var shouldUseHeading = true

    var body: some View {
        Toggle("Switch to heading", isOn: $shouldUseHeading)
        MapView(region: $region, useHeading: $shouldUseHeading)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
