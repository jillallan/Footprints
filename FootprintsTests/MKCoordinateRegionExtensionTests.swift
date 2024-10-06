//
//  MKCoordinateRegionExtensionTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/09/2024.
//

import CoreLocation
import MapKit
import Testing
@testable import Footprints

struct MKCoordinateRegionExtensionTests {

    @Test("Check coordinate region calculation", .tags(.extensions))
    func mkCoordinateRegion_calculateRegion_shoulReturnsRegionForRangeOfCoordinates() async throws {
        let coordinates = (0..<10).map { _ in
            CLLocationCoordinate2D(
                latitude: Double.random(in: -90...90),
                longitude: Double.random(in: -180...180)
            )
        }

        let latitudeRange = coordinates.map(\.latitude).max()! - coordinates.map(\.latitude).min()!
        let longitudeRange = coordinates.map(\.longitude).max()! - coordinates.map(\.longitude).min()!
        let latitudeMidRange = (coordinates.map(\.latitude).min()!  + coordinates.map(\.latitude).max()!) / 2.0
        let longitudeMidRange = (coordinates.map(\.longitude).min()!  + coordinates.map(\.longitude).max()!) / 2.0

        let tempRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitudeMidRange, longitude: longitudeMidRange),
            span: MKCoordinateSpan(latitudeDelta: latitudeRange, longitudeDelta: longitudeRange)
        )

        let region = try #require(MKCoordinateRegion.calculateRegion(from: coordinates))

        #expect(region == tempRegion)
    }

    @Test("Check coordinate region calculation", .tags(.extensions))
    func mkCoordinateRegion_calculateRegion_shoulReturnsRegionForSingleCoordinate() async throws {
        let coordinates = [CLLocationCoordinate2D(latitude: 51.5, longitude: 0)]

        let latitudeRange = coordinates.map(\.latitude).max()! - coordinates.map(\.latitude).min()!
        let longitudeRange = coordinates.map(\.longitude).max()! - coordinates.map(\.longitude).min()!
        let latitudeMidRange = (coordinates.map(\.latitude).min()!  + coordinates.map(\.latitude).max()!) / 2.0
        let longitudeMidRange = (coordinates.map(\.longitude).min()!  + coordinates.map(\.longitude).max()!) / 2.0

        let tempRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitudeMidRange, longitude: longitudeMidRange),
            span: MKCoordinateSpan(latitudeDelta: latitudeRange, longitudeDelta: longitudeRange)
        )

        let region = try #require(MKCoordinateRegion.calculateRegion(from: coordinates))

        #expect(region == tempRegion)

    }
}
