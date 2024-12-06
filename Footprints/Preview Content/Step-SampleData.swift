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
    static let stJohnsLane = Step(
        timestamp: Date.from(string: "2016/07/28 08:15:00"),
        latitude: 51.435876,
        longitude: -2.597505
    )
    
    @MainActor
    /// A sample step
    static let bedminsterStation = Step(
        timestamp: Date.from(string: "2016/07/28 08:15:00"),
//        latitude: 51.449532,
//        longitude: -2.589309
        latitude: 51.440658,
        longitude: -2.593528
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
        timestamp: Date.from(string: "2016/07/28 16:18:00"),
        latitude: 50.836228,
        longitude: 4.335497
    )

    @MainActor
    /// A sample step
    static let grandPlace = Step(
        timestamp: Date.from(string: "2016/07/29 09:00:00"),
        latitude: 50.846708,
        longitude: 4.352538
    )

    @MainActor
    /// A sample step
    static let atomium = Step(
        timestamp: Date.from(string: "2016/07/29 10:18:00"),
        latitude: 50.894938,
        longitude: 4.341478
    )

    @MainActor
    /// A sample step
    static let cologne = Step(
        timestamp: Date.from(string: "2016/07/29 16:00:00"),
        latitude: 50.941319,
        longitude: 6.958210
    )

    @MainActor
    /// A sample step
    static let warsaw = Step(
        timestamp: Date.from(string: "2016/07/30 12:00:00"),
        latitude: 52.249812,
        longitude: 21.012149
    )
    
    @MainActor
    /// A sample step
    static let everestBaseCamp = Step(
        timestamp: Date.from(string: "2016/10/15 12:00:00"),
        latitude: 27.828871,
        longitude: 86.738004
    )
    
    @MainActor
    /// A sample step
    static let statueOfLiberty = Step(
        timestamp: Date.from(string: "2022/09/13 12:00:00"),
        latitude: 40.689202,
        longitude: -74.044543
    )
}
