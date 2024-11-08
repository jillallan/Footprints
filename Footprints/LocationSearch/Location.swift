//
//  Location.swift
//  Footprints
//
//  Created by Jill Allan on 31/10/2024.
//

import Foundation
import MapKit
import SwiftData

@Model
final class Location {
    var name: String
    var latitude: Double
    var longitude: Double
    var radius: Double
    var encodedMapItem: Data?
    
    var steps = [Step]()

    var locationSteps: [Step] {
        return steps.sorted()
    }
    
    /// Required property for CustomDebugStringConvertible protocol
    var debugDescription: String {
        """
        Name: \(name)\n \
        latitude: \(latitude)\n \
        longitude: \(longitude)\n \
        radius: \(radius)\n 
        """
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var mapItem: MKMapItem {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        guard let data = encodedMapItem else { return mapItem }
        guard let decodedMapItem = MKMapItem.decode(from: data) else { return mapItem }
    
        return decodedMapItem
    }
    
    init(
        name: String,
        latitude: Double = 0.0,
        longitude: Double = 0.0,
        radius: Double = 0.0,
        encodedMapItem: Data = Data()
    ) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.encodedMapItem = encodedMapItem
    }
    
    convenience init(mapItem: MKMapItem) {
        
        let region = mapItem.placemark.region
        let radius = region?.getRadius() ?? 0.0
        let data = mapItem.encode() ?? Data()
        
        self.init(
            name: mapItem.name ?? "Unknown Location",
            latitude: mapItem.placemark.coordinate.latitude,
            longitude: mapItem.placemark.coordinate.longitude,
            radius: radius,
            encodedMapItem: data
        )
    }
    
    convenience init(coordinate: CLLocationCoordinate2D) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        let radius = placemark.region?.getRadius() ?? 0.0
        let data = mapItem.encode() ?? Data()
        
        self.init(
            name: mapItem.name ?? "Unknown Location",
            latitude: mapItem.placemark.coordinate.latitude,
            longitude: mapItem.placemark.coordinate.longitude,
            radius: radius,
            encodedMapItem: data
        )
    }
}
