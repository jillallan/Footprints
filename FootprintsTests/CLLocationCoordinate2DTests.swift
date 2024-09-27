//
//  CLLocationCoordinate2D.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/09/2024.
//

import CoreLocation
import Testing
@testable import Footprints

struct CLLocationCoordinate2DTests {

    @Test func CLLocationCoordinate2D_calculateCentreCoordinate_shouldReturnCentreCoordinate() async throws {
        let coordinates = (0..<10).map { _ in
            CLLocationCoordinate2D(
                latitude: Double.random(in: -90...90),
                longitude: Double.random(in: -180...180)
            )
        }

        let latitudeMidRange = (coordinates.map(\.latitude).min()!  + coordinates.map(\.latitude).max()!) / 2.0
        let longitudeMidRange = (coordinates.map(\.longitude).min()!  + coordinates.map(\.longitude).max()!) / 2.0
        let centre = try #require(CLLocationCoordinate2D.calculateCentre(of: coordinates))

        #expect(centre == CLLocationCoordinate2D(latitude: latitudeMidRange, longitude: longitudeMidRange))
    }

}
