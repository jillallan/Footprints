//
//  FootprintsTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 09/08/2024.
//

import CoreLocation
import MapKit
import Testing
@testable import Footprints

@Suite(.tags(.extensions))
struct MKCoordinateSpanExtensionsTests {

    @Test("Check coordinate span calculation", .tags(.extensions)) func example() async throws {
        let coordinates = (0..<10).map { _ in
            CLLocationCoordinate2D(
                latitude: Double.random(in: -90...90),
                longitude: Double.random(in: -180...180)
            )
        }

        let latitudeRange = coordinates.map(\.latitude).max()! - coordinates.map(\.latitude).min()!
        let longitudeRange = coordinates.map(\.longitude).max()! - coordinates.map(\.longitude).min()!

        let span = try #require(MKCoordinateSpan.calculateSpan(of: coordinates))

        #expect(span == MKCoordinateSpan(latitudeDelta: latitudeRange, longitudeDelta: longitudeRange))
    }
    
    @Test func testMKCoordinateSpan_equatable_shouldReturnTrueWhenSpansAreTheSame() {
        let lhsSpan = MKCoordinateSpan(
            latitudeDelta: Double.random(in: -90...90),
            longitudeDelta: Double.random(in: -180...180)
        )
        let rhsSpan = lhsSpan

        #expect(lhsSpan == rhsSpan, "Matching coordinates should match")
    }

    @Test func testMKCoordinateSpan_equatable_shouldReturnFalseWhenSpansAreNotTheSame() {
        let lhsSpan = MKCoordinateSpan(
            latitudeDelta: Double.random(in: -90...90),
            longitudeDelta: Double.random(in: -180...180)
        )
        let rhsSpan = MKCoordinateSpan(
            latitudeDelta: Double.random(in: -90...90),
            longitudeDelta: Double.random(in: -180...180)
        )

        #expect(!(lhsSpan == rhsSpan), "Coordinates should not match")
    }

}
