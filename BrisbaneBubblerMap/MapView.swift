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
    @Binding var useHeading: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func getUserTrackingMode() -> MKUserTrackingMode {
        if(useHeading) {
            return MKUserTrackingMode.followWithHeading
        } else {
            return MKUserTrackingMode.follow
        }
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = getUserTrackingMode()
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.setRegion(region, animated: true)
        
        context.coordinator.onChange(of: useHeading) { [self] newValue in
            view.userTrackingMode = self.getUserTrackingMode()
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        private var headingResetWorkItem: DispatchWorkItem?

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func onChange<Value: Equatable>(of value: Value, perform action: @escaping (Value) -> Void) {
            // Implement onChange here
            // You can use a Combine publisher to observe changes in the value
            
            // For example, you can use the following code:
            let publisher = CurrentValueSubject<Value, Never>(value)
            publisher
                .removeDuplicates()
                .sink { value in
                    action(value)
                }
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.region = mapView.region
            
            // Reset the heading
            if mapView.userTrackingMode != self.parent.getUserTrackingMode() {
                resetHeading(in: mapView)
            }
        }

        private func resetHeading(in mapView: MKMapView) {
            // Cancel the previous reset work item if it's still pending
            headingResetWorkItem?.cancel()

            // Create a new work item to reset the heading after a delay
            let workItem = DispatchWorkItem { [weak mapView] in
                mapView?.setUserTrackingMode(self.parent.getUserTrackingMode(), animated: true)
            }

            // Save the work item and schedule it to run after a delay
            headingResetWorkItem = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
        }
    }
}
