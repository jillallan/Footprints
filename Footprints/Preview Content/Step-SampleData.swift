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
    static let brusselsMidi = Step(
        timestamp: Date.from(string: "2016/07/29 16:18:00"),
        latitude: 50.836228,
        longitude: 4.335497
    )

    @MainActor
    /// A sample step
    static let grandPlace = Step(
        timestamp: Date.from(string: "2016/07/29 09:00:00"),
        latitude: 50.846858680448115,
        longitude: 4.35252433960369
    )

    @MainActor
    /// A sample step
    static let atomium = Step(
        timestamp: Date.from(string: "2016/07/29 10:18:00"),
        latitude: 50.89504108327435,
        longitude: 4.34157615494866
    )

    @MainActor
    /// A sample step
    static let cologne = Step(
        timestamp: Date.from(string: "2016/07/29 16:00:00"),
        latitude: 50.94145414220289,
        longitude: 6.95822775310139
    )

    @MainActor
    /// A sample step
    static let warsaw = Step(
        timestamp: Date.from(string: "2016/07/30 12:00:00"),
        latitude: 52.24994691355245,
        longitude: 21.012202783852473
    )
}
