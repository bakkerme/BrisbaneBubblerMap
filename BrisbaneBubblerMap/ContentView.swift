//
//  ContentView.swift
//  BrisbaneBubblerMap
//
//  Created by Brandon Bakker on 27/3/2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -27.467570, longitude: 153.026215), // BNE City
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var bubblerAnnotations:[BubblerAnnotation] = []
    @State private var mapView:MKMapView = MKMapView()
    
    var body: some View {
        ZStack {
            MapView(region: $region, bubblerData: $bubblerAnnotations, mapView: $mapView)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    APICall().getBubblerData { (bubblers) in
                        self.bubblerAnnotations = bubblers
                    }
                }
            VStack {
                HStack {
                    Spacer()
                    UserTrackingButton(mapView: $mapView)
                        .frame(width: 50, height: 50)
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                }
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
