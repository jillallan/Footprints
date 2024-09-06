//
//  Step-SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation

extension Step {
    @MainActor
    /// A sample step
    static let bedminsterStation = Step(
        timestamp: Date.from(string: "2016/07/28 08:15:00"),
        latitude: 51.44070779798049,
        longitude: -2.593617389202319
    )

    @MainActor
    /// A sample step
    static let templeMeads = Step(
        timestamp: Date.from(string: "2016/07/28 08:25:00"),
        latitude: 51.449192,
        longitude: -2.580163
    )

    @MainActor
    /// A sample step
    static let paddington = Step(
        timestamp: Date.from(string: "2016/07/28 11:00:00"),
        latitude: 51.517431,
        longitude: -0.178055
    )

    @MainActor
    /// A sample step
    static let stPancras = Step(
        timestamp: Date.from(string: "2016/07/28 12:00:00"),
        latitude: 51.529969,
        longitude: -0.126060
    )

    @MainActor
    /// A sample step
    static let Ixelles = Step(
        timestamp: Date.from(string: "2016/07/28 16:18:00"),
        latitude: 50.838023,
        longitude: 4.373529
    )
}
