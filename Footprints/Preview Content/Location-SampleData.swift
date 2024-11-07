//
//  Location-SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 07/11/2024.
//

import Foundation

extension Location {
    
    @MainActor
    /// A sample location
    static let stJohnsLane = Location(
        name: "384 St John's Lane",
        subThoroughfare: "384",
        thoroughfare: "St John's Lane",
        subLocality: "Bedminster",
        locality: "Bristol",
        subAdministrativeArea: "Bristol",
        administrativeArea: "England",
        postalCode: "BS3 5BA",
        isoCountryCode: "GB",
        country: "United Kingdom",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "nil",
        pointOfInterestCategory: "nil",
        mapItemIdentifier: "nil",
        latitude: 51.435876,
        longitude: -2.5975049,
        radius: 70.59,
        locationType: .other,
        locationCategory: .other
    )
    
    @MainActor
    /// A sample location
    static let bedminsterStation = Location(
        name: "Bedminster Station",
        subThoroughfare: "nil",
        thoroughfare: "nil",
        subLocality: "nil",
        locality: "Bristol",
        subAdministrativeArea: "Bristol",
        administrativeArea: "England",
        postalCode: "nil",
        isoCountryCode: "GB",
        country: "United Kingdom",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "nil",
        pointOfInterestCategory: "MKPOICategoryPublicTransport",
        mapItemIdentifier: "IA38F89DAE1ADF2C1",
        latitude: 51.4406576,
        longitude: -2.593528,
        radius: 141.18,
        locationType: .pointOfInterest,
        locationCategory: .publicTransport
    )
    
    @MainActor
    /// A sample location
    static let templeMeads = Location(
        name: "Bristol Temple Meads Station",
        subThoroughfare: "nil",
        thoroughfare: "nil",
        subLocality: "nil",
        locality: "Bristol",
        subAdministrativeArea: "Bristol",
        administrativeArea: "England",
        postalCode: "nil",
        isoCountryCode: "GB",
        country: "United Kingdom",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "nil",
        pointOfInterestCategory: "MKPOICategoryPublicTransport",
        mapItemIdentifier: "I6B27843C6039FCCC",
        latitude: 51.4491918,
        longitude: -2.5801629,
        radius: 302.26,
        locationType: .pointOfInterest,
        locationCategory: .publicTransport
    )
    
    @MainActor
    /// A sample location
    static let paddington = Location(
        name: "London Paddington Station",
        subThoroughfare: "nil",
        thoroughfare: "nil",
        subLocality: "nil",
        locality: "London",
        subAdministrativeArea: "London",
        administrativeArea: "England",
        postalCode: "nil",
        isoCountryCode: "GB",
        country: "United Kingdom",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "nil",
        pointOfInterestCategory: "MKPOICategoryPublicTransport",
        mapItemIdentifier: "ICDB451B5B3C0B994",
        latitude: 51.5174313,
        longitude: -0.1780548,
        radius: 265.34,
        locationType: .pointOfInterest,
        locationCategory: .publicTransport
    )
    
    @MainActor
    /// A sample location
    static let stPancras = Location(
        name: "St. Pancras Renaissance Hotel London",
        subThoroughfare: "nil",
        thoroughfare: "Euston Road",
        subLocality: "Camden",
        locality: "London",
        subAdministrativeArea: "London",
        administrativeArea: "England",
        postalCode: "NW1 2AR",
        isoCountryCode: "GB",
        country: "United Kingdom",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "nil",
        pointOfInterestCategory: "MKPOICategoryHotel",
        mapItemIdentifier: "I8E708AC0FC113151",
        latitude: 51.529906,
        longitude: -0.125947,
        radius: 141.18,
        locationType: .pointOfInterest,
        locationCategory: .hotel
    )
    
    @MainActor
    /// A sample location
    static let brusselsMidi = Location(
        name: "Brüssel gare du midi",
        subThoroughfare: "nil",
        thoroughfare: "Place Victor Horta",
        subLocality: "nil",
        locality: "Saint-Gilles",
        subAdministrativeArea: "Brussels-Capital",
        administrativeArea: "Brussels-Capital Region",
        postalCode: "1060",
        isoCountryCode: "BE",
        country: "Belgium",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "nil",
        pointOfInterestCategory: "MKPOICategoryRestaurant",
        mapItemIdentifier: "IAB8940F55AF47DBA",
        latitude: 50.8361743,
        longitude: 4.3356853,
        radius: 141.18,
        locationType: .pointOfInterest,
        locationCategory: .restaurant
    )
    
    @MainActor
    /// A sample location
    static let grandPlace = Location(
        name: "Grand-Place",
        subThoroughfare: "nil",
        thoroughfare: "nil",
        subLocality: "Pentagone",
        locality: "Brussels",
        subAdministrativeArea: "Brussels-Capital",
        administrativeArea: "Brussels-Capital Region",
        postalCode: "1000",
        isoCountryCode: "BE",
        country: "Belgium",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "Grand-Place of Brussels",
        pointOfInterestCategory: "nil",
        mapItemIdentifier: "I557B4582AF2663B4",
        latitude: 50.8467078,
        longitude: 4.3525382,
        radius: 141.18,
        locationType: .other,
        locationCategory: .other
    )
    
    @MainActor
    /// A sample location
    static let atomium = Location(
        name: "Atomium",
        subThoroughfare: "1",
        thoroughfare: "Place de l'Atomium",
        subLocality: "Laeken",
        locality: "Brussels",
        subAdministrativeArea: "Brussels-Capital",
        administrativeArea: "Brussels-Capital Region",
        postalCode: "1020",
        isoCountryCode: "BE",
        country: "Belgium",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "nil",
        pointOfInterestCategory: "MKPOICategoryLandmark",
        mapItemIdentifier: "I628BA8B6C6C8269E",
        latitude: 50.8949382,
        longitude: 4.3414779,
        radius: 141.18,
        locationType: .pointOfInterest,
        locationCategory: .landmark
    )
    
    @MainActor
    /// A sample location
    static let cologne = Location(
        name: "Cologne Cathedral",
        subThoroughfare: "4",
        thoroughfare: "Domkloster",
        subLocality: "Innenstadt",
        locality: "Cologne",
        subAdministrativeArea: "Cologne",
        administrativeArea: "North Rhine-Westphalia",
        postalCode: "50667",
        isoCountryCode: "DE",
        country: "Germany",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "Cologne Cathedral",
        pointOfInterestCategory: "MKPOICategoryLandmark",
        mapItemIdentifier: "IE15A450139BB2DDC",
        latitude: 50.9413186,
        longitude: 6.9582098,
        radius: 148.99,
        locationType: .pointOfInterest,
        locationCategory: .landmark
    )
    
    @MainActor
    /// A sample location
    static let warsaw = Location(
        name: "Old Town Market Place",
        subThoroughfare: "1",
        thoroughfare: "Rynek Starego Miasta",
        subLocality: "Stare Miasto",
        locality: "Warsaw",
        subAdministrativeArea: "County Warszawa",
        administrativeArea: "Masovian",
        postalCode: "00-272",
        isoCountryCode: "PL",
        country: "Poland",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "Old Town Market Place",
        pointOfInterestCategory: "nil",
        mapItemIdentifier: "I8B53C078EDF25B4",
        latitude: 52.2498121,
        longitude: 21.0121489,
        radius: 141.18,
        locationType: .other,
        locationCategory: .other
    )
    
    @MainActor
    /// A sample location
    static let everestBaseCamp = Location(
        name: "Annapurna Base Camp Trek",
        subThoroughfare: "nil",
        thoroughfare: "Everest Base Camp Rte",
        subLocality: "nil",
        locality: "nil",
        subAdministrativeArea: "nil",
        administrativeArea: "Sagarmatha",
        postalCode: "nil",
        isoCountryCode: "NP",
        country: "Nepal",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "nil",
        pointOfInterestCategory: "nil",
        mapItemIdentifier: "IA8C0AD7E20B7F0A4",
        latitude: 27.82887,
        longitude: 86.73801,
        radius: 141.17,
        locationType: .other,
        locationCategory: .other
    )
    
    @MainActor
    /// A sample location
    static let statueOfLiberty = Location(
        name: "Statue of Liberty",
        subThoroughfare: "nil",
        thoroughfare: "Liberty Island",
        subLocality: "nil",
        locality: "New York",
        subAdministrativeArea: "New York",
        administrativeArea: "NY",
        postalCode: "10004",
        isoCountryCode: "US",
        country: "United States",
        inlandWater: "nil",
        ocean: "nil",
        areaOfInterest: "Liberty Island",
        pointOfInterestCategory: "MKPOICategoryLandmark",
        mapItemIdentifier: "I2C4C04802A9624C1",
        latitude: 40.6892015,
        longitude: -74.0445433,
        radius: 265.01,
        locationType: .pointOfInterest,
        locationCategory: .landmark
    )
    
}
