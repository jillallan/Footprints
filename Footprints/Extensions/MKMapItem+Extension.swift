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
}

//// Encode the MKMapItem to Data
//if let encodedData = mapItem.encode() {
//    print("Encoded successfully!")
//    
//    // Decode the Data back to MKMapItem
//    if let decodedMapItem = MKMapItem.decode(from: encodedData) {
//        print("Decoded successfully!\nName: \(decodedMapItem.name ?? "Unknown")")
//        print("Coordinates: \(decodedMapItem.placemark.coordinate)")
//    } else {
//        print("Decoding failed.")
//    }
//} else {
//    print("Encoding failed.")
//}
