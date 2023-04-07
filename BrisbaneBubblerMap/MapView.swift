//
//  MapView.swift
//  BrisbaneBubblerMap
//
//  Created by Brandon Bakker on 29/3/2023.
//

import Foundation
import SwiftUI
import MapKit
import Combine

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var bubblerData: [BubblerAnnotation]
    @Binding var mapView: MKMapView
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
//        view.setRegion(region, animated: true)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            mapView.addAnnotations(self.parent.bubblerData as [MKAnnotation])
        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        }
    }
}
