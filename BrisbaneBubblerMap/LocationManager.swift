//
//  LocationManager.swift
//  BrisbaneBubblerMap
//
//  Created by Brandon Bakker on 29/3/2023.
//

import UIKit
import MapKit
import CoreLocation


//class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
//    @Published var region = MKCoordinateRegion()
//    private let manager = CLLocationManager()
//
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        locations.last.map {
//            region = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
//                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
//            )
//        }
//    }
//}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }
}
