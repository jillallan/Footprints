//
//  PointOfInterestCategory.swift
//  Footprints
//
//  Created by Jill Allan on 31/10/2024.
//

import Foundation
import SwiftData
import SwiftUICore

enum LocationType: String, Codable {
    case pointOfInterest
    case physicalFeature
    case territory
    case address
    case other
}

enum LocationCategory: String, Codable {
    case museum
    case musicVenue
    case theater
    case library
    case planetarium
    case school
    case university
    case movieTheater
    case nightlife
    case firestation
    case hospital
    case pharmacy
    case police
    case castle
    case fortress
    case landmark
    case nationalMonument
    case bakery
    case brewery
    case cafe
    case distillery
    case foodMarket
    case restaurant
    case winery
    case animalService
    case atm
    case automotiveRepair
    case bank
    case beauty
    case evCharger
    case fitnessCenter
    case laundry
    case mailbox
    case postOffice
    case restroom
    case spa
    case store
    case amusementPark
    case aquarium
    case beach
    case campground
    case fairground
    case marina
    case nationalPark
    case park
    case rvPark
    case zoo
    case baseball
    case basketball
    case bowling
    case goKart
    case golf
    case hiking
    case miniGolf
    case rockClimbing
    case skatePark
    case skating
    case soccer
    case stadium
    case tennis
    case volleyball
    case airport
    case carRental
    case conventionCenter
    case gasStation
    case hotel
    case parking
    case publicTransport
    case fishing
    case kayaking
    case surfing
    case swimming
    case other
}

extension LocationCategory: CaseIterable {
    var icon: String {
        switch self {
        case .museum:
            "building.columns.fill"
        case .castle:
            "building.columns.fill"
        case .restaurant:
            "fork.knife"
        case .other:
            "car"
        case .musicVenue:
            "music.note"
        case .theater:
            "building.columns.fill"
        case .library:
            "building.columns.fill"
        case .planetarium:
            "building.columns.fill"
        case .school:
            "building.columns.fill"
        case .university:
            "building.columns.fill"
        case .movieTheater:
            "building.columns.fill"
        case .nightlife:
            "building.columns.fill"
        case .firestation:
            "building.columns.fill"
        case .hospital:
            "building.columns.fill"
        case .pharmacy:
            "building.columns.fill"
        case .police:
            "building.columns.fill"
        case .fortress:
            "building.columns.fill"
        case .landmark:
            "star.fill"
        case .nationalMonument:
            "building.columns.fill"
        case .bakery:
            "building.columns.fill"
        case .brewery:
            "building.columns.fill"
        case .cafe:
            "building.columns.fill"
        case .distillery:
            "building.columns.fill"
        case .foodMarket:
            "building.columns.fill"
        case .winery:
            "building.columns.fill"
        case .animalService:
            "building.columns.fill"
        case .atm:
            "building.columns.fill"
        case .automotiveRepair:
            "building.columns.fill"
        case .bank:
            "building.columns.fill"
        case .beauty:
            "building.columns.fill"
        case .evCharger:
            "building.columns.fill"
        case .fitnessCenter:
            "building.columns.fill"
        case .laundry:
            "building.columns.fill"
        case .mailbox:
            "building.columns.fill"
        case .postOffice:
            "building.columns.fill"
        case .restroom:
            "building.columns.fill"
        case .spa:
            "building.columns.fill"
        case .store:
            "building.columns.fill"
        case .amusementPark:
            "building.columns.fill"
        case .aquarium:
            "building.columns.fill"
        case .beach:
            "building.columns.fill"
        case .campground:
            "building.columns.fill"
        case .fairground:
            "building.columns.fill"
        case .marina:
            "building.columns.fill"
        case .nationalPark:
            "building.columns.fill"
        case .park:
            "building.columns.fill"
        case .rvPark:
            "building.columns.fill"
        case .zoo:
            "building.columns.fill"
        case .baseball:
            "building.columns.fill"
        case .basketball:
            "building.columns.fill"
        case .bowling:
            "building.columns.fill"
        case .goKart:
            "building.columns.fill"
        case .golf:
            "building.columns.fill"
        case .hiking:
            "building.columns.fill"
        case .miniGolf:
            "building.columns.fill"
        case .rockClimbing:
            "building.columns.fill"
        case .skatePark:
            "building.columns.fill"
        case .skating:
            "building.columns.fill"
        case .soccer:
            "building.columns.fill"
        case .stadium:
            "building.columns.fill"
        case .tennis:
            "building.columns.fill"
        case .volleyball:
            "building.columns.fill"
        case .airport:
            "building.columns.fill"
        case .carRental:
            "building.columns.fill"
        case .conventionCenter:
            "building.columns.fill"
        case .gasStation:
            "building.columns.fill"
        case .hotel:
            "building.columns.fill"
        case .parking:
            "building.columns.fill"
        case .publicTransport:
            "building.columns.fill"
        case .fishing:
            "building.columns.fill"
        case .kayaking:
            "building.columns.fill"
        case .surfing:
            "building.columns.fill"
        case .swimming:
            "building.columns.fill"
        }
        
    }
    
    var color: Color {
        switch self {
        case .museum:
            Color.blue
        case .castle:
            Color.red
        case .restaurant:
            Color.yellow
        case .other:
            Color.purple
        case .musicVenue:
            Color.purple
        case .theater:
            Color.purple
        case .library:
            Color.purple
        case .planetarium:
            Color.purple
        case .school:
            Color.purple
        case .university:
            Color.purple
        case .movieTheater:
            Color.purple
        case .nightlife:
            Color.purple
        case .firestation:
            Color.purple
        case .hospital:
            Color.purple
        case .pharmacy:
            Color.purple
        case .police:
            Color.purple
        case .fortress:
            Color.purple
        case .landmark:
            Color.purple
        case .nationalMonument:
            Color.purple
        case .bakery:
            Color.purple
        case .brewery:
            Color.purple
        case .cafe:
            Color.purple
        case .distillery:
            Color.purple
        case .foodMarket:
            Color.purple
        case .winery:
            Color.purple
        case .animalService:
            Color.purple
        case .atm:
            Color.purple
        case .automotiveRepair:
            Color.purple
        case .bank:
            Color.purple
        case .beauty:
            Color.purple
        case .evCharger:
            Color.purple
        case .fitnessCenter:
            Color.purple
        case .laundry:
            Color.purple
        case .mailbox:
            Color.purple
        case .postOffice:
            Color.purple
        case .restroom:
            Color.purple
        case .spa:
            Color.purple
        case .store:
            Color.purple
        case .amusementPark:
            Color.purple
        case .aquarium:
            Color.purple
        case .beach:
            Color.purple
        case .campground:
            Color.purple
        case .fairground:
            Color.purple
        case .marina:
            Color.purple
        case .nationalPark:
            Color.purple
        case .park:
            Color.purple
        case .rvPark:
            Color.purple
        case .zoo:
            Color.purple
        case .baseball:
            Color.purple
        case .basketball:
            Color.purple
        case .bowling:
            Color.purple
        case .goKart:
            Color.purple
        case .golf:
            Color.purple
        case .hiking:
            Color.purple
        case .miniGolf:
            Color.purple
        case .rockClimbing:
            Color.purple
        case .skatePark:
            Color.purple
        case .skating:
            Color.purple
        case .soccer:
            Color.purple
        case .stadium:
            Color.purple
        case .tennis:
            Color.purple
        case .volleyball:
            Color.purple
        case .airport:
            Color.purple
        case .carRental:
            Color.purple
        case .conventionCenter:
            Color.purple
        case .gasStation:
            Color.purple
        case .hotel:
            Color.purple
        case .parking:
            Color.purple
        case .publicTransport:
            Color.purple
        case .fishing:
            Color.purple
        case .kayaking:
            Color.purple
        case .surfing:
            Color.purple
        case .swimming:
            Color.purple    
        }
        
    }
}
