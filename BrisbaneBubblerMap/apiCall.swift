//
//  APICall.swift
//  BrisbaneBubblerMap
//
//  Created by Brandon Bakker on 30/3/2023.
//

import Foundation
import MapKit
import CoreLocation

enum NetworkError: Error {
    case responseError
}

class APICall {
    func getBubblerData(success: @escaping ([BubblerAnnotation]) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://services2.arcgis.com/dEKgZETqwmDAh1rP/arcgis/rest/services/park_drinking_fountain_tap_locations/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json") else { return }
//        guard let url = URL(string: "https://localhost") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                // Call the completion handler with the error
                failure(error)
                return
            }
            
            guard let data = data else {
                // Create and throw a new error
                let error = NetworkError.responseError
                failure(error)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(BCCResponse.self, from: data)
                // Call the completion handler with the successful result
                success(self.convertBCCFeaturesToCoordinates(features: response.features))
            } catch {
                // Call the completion handler with the error
                failure(error)
            }
        }
        .resume()
    }
    
    func convertBCCFeaturesToCoordinates(features: [Feature]) -> [BubblerAnnotation] {
        var bubblerReturns: [BubblerAnnotation] = []
        for feature in features {
            bubblerReturns.append(BubblerAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: feature.attributes.y,
                    longitude: feature.attributes.x
                ),
                title: feature.attributes.itemDescription,
                subtitle: feature.attributes.parkName
            ))
        }
        
        return bubblerReturns
    }
}

class BubblerAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?

    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
