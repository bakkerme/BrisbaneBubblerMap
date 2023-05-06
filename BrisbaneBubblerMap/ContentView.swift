//
//  ContentView.swift
//  BrisbaneBubblerMap
//
//  Created by Brandon Bakker on 27/3/2023.
//

import SwiftUI
import MapKit

var ERROR_MESSAGE = "Could not load bubbler locations from Brisbane City Council API. Please check your internet connection."

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -27.467570, longitude: 153.026215), // BNE City
        span: MKCoordinateSpan(latitudeDelta: 0.00, longitudeDelta: 0.00)
    )
    @State private var bubblerAnnotations:[BubblerAnnotation] = []
    @State private var mapView:MKMapView = MKMapView()
    
    @State private var isErrorAlertShown = false
    @State private var errorMessage = ""
    func showErrorAlert(message: String) {
        errorMessage = message
        isErrorAlertShown = true
    }
    
    var body: some View {
        ZStack {
            MapView(region: $region, bubblerData: $bubblerAnnotations, mapView: $mapView)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    APICall().getBubblerData(
                        success: { bubblers in
                            self.bubblerAnnotations = bubblers
                        },
                        failure: { error in
                            self.showErrorAlert(message: ERROR_MESSAGE)
                        }
                    )
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
        .alert(isPresented: $isErrorAlertShown) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum DisplayError: LocalizedError {
    
    case basic
    
    var errorDescription: String? {
        switch self {
        case .basic:
            return "Title"
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .basic:
            return "Message"
        }
    }
}
