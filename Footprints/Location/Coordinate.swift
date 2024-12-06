//
//  Coordinate.swift
//  Footprints
//
//  Created by Jill Allan on 16/11/2024.
//

import CoreLocation
import Foundation
import MapKit

struct Coordinate: Identifiable, Equatable {
    let id = UUID()
    var latitude: Double
    var longitude: Double
    
    var coordinateString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 5
        
        let latitudeFormatted = formatter.string(from: NSNumber(value: abs(latitude)))!
        let longitudeFormatted = formatter.string(from: NSNumber(value: abs(longitude)))!
    
        var latitudeString = "\(latitudeFormatted)\u{00B0} N"
        var longitudeString = "\(longitudeFormatted)\u{00B0} E"
        
        if latitude < 0 {
            latitudeString = "\(latitudeFormatted)\u{00B0} S"
        }
        if longitude < 0 {
            longitudeString = "\(longitudeFormatted)\u{00B0} W"
        }
        return "\(latitudeString), \(longitudeString)"
    }
    
    var clLocationCoordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var region: MKCoordinateRegion {
        let Span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        return MKCoordinateRegion(center: clLocationCoordinate2D, span: Span)
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension Coordinate {
    init(from coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}
