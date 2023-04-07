//
//  UserTrackingButtons.swift
//  BrisbaneBubblerMap
//
//  Created by Brandon Bakker on 7/4/2023.
//

import Foundation
import SwiftUI
import MapKit

struct UserTrackingButton: UIViewRepresentable {
    @Binding var mapView: MKMapView

    func makeUIView(context: Context) -> MKUserTrackingButton {
        let button = MKUserTrackingButton(mapView: mapView)
        button.layer.backgroundColor = UIColor.systemBackground.cgColor
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }

    func updateUIView(_ button: MKUserTrackingButton, context: Context) {
    }
}
