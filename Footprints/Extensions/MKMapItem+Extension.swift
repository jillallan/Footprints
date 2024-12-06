//
//  MKMapItem+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 07/11/2024.
//

import Foundation
import MapKit

extension MKMapItem {
    /// Encodes an MKMapItem to Data
    func encode() -> Data? {
        let archivedData = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
        return archivedData
    }
    
    /// Decodes Data to an MKMapItem
    static func decode(from data: Data) -> MKMapItem? {
        guard let unarchivedObject = try? NSKeyedUnarchiver.unarchivedObject(ofClass: MKMapItem.self, from: data) else {
            return nil
        }
        return unarchivedObject
    }
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let region = self.placemark.region
        guard let radius = region?.getRadius() else { return false }
        let circularRegion = CLCircularRegion(center: coordinate, radius: radius, identifier: "mapItemRegion")
        return circularRegion.contains(coordinate)
    }
}
