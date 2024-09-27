//
//  DoubleExtensionTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/09/2024.
//

import Testing
@testable import Footprints

struct DoubleExtensionTests {

    @Test func double_rangeOf_returnsRangeOfArrayOfDoubles() async throws {
        let doubles = (0..<10).map { _ in
            Double.random(in: -90...90)
        }

        let min = doubles.min()!
        let max = doubles.max()!

        let range = try #require(Double.range(of: doubles))
        #expect(range == (max - min))

    }

    @Test func double_rangeOf_returnsEmptyRangeIfArrayIsEmpty() async throws {
        let doubles: [Double] = []
        
        #expect(Double.range(of: doubles) == nil)
    }

    @Test func double_midRangeOf_returnsAverageOfMinAndMaxOfArrayOfDoubles() async throws {
        let doubles = (0..<10).map { _ in
            Double.random(in: -90...90)
        }

        let min = doubles.min()!
        let max = doubles.max()!

        let midRange = try #require(Double.midRange(of: doubles))
        #expect(midRange == ((max + min) / 2))
    }

    @Test func double_midRangeOf_returnsEmptyRangeIfArrayIsEmpty() async throws {
        let doubles: [Double] = []
        
        #expect(Double.midRange(of: doubles) == nil)
    }
}
