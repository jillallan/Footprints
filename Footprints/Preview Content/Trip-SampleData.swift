//
//  Trip-SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation

extension Trip {

    @MainActor
    /// A sample trip
    static let bedminsterToBeijing = Trip(
        title: "Bedminster to Beijing",
//        title: "Bedminster to Beijing via Eurpoe, Russia and Mongolia",
        startDate: Date.from(string: "2016/07/28 08:06:00"),
        endDate: Date.from(string: "2016/09/02 12:00:00"),
        isAutoTrackingOn: false
    )

    @MainActor
    /// A sample trip
    static let mountains = Trip(
        title: "Mountains",
        startDate: Date.from(string: "2016/09/03 08:06:00"),
        endDate: Date.from(string: "2016/09/30 12:00:00"),
        isAutoTrackingOn: false
    )

    @MainActor
    /// A sample trip
    static let anglesey = Trip(
        title: "Anglesey",
        startDate: Date.from(string: "2024/04/01 08:06:00"),
        endDate: Date.from(string: "2024/04/09 12:00:00"),
        isAutoTrackingOn: false
    )

    @MainActor
    /// A sample trip
    static let greece = Trip(
        title: "Greece",
        startDate: Date.from(string: "2023/05/03 08:06:00"),
        endDate: Date.from(string: "2023/05/24 12:00:00"),
        isAutoTrackingOn: false
    )

    @MainActor
    /// A sample trip
    static let london = Trip(
        title: "London",
        startDate: Date.from(string: "2024/03/01 08:06:00"),
        endDate: Date.from(string: "2024/03/02 12:00:00"),
        isAutoTrackingOn: false
    )

    @MainActor
    /// A sample trip
    static let france = Trip(
        title: "France",
        startDate: Date.from(string: "2022/06/04 08:06:00"),
        endDate: Date.from(string: "2022/06/25 12:00:00"),
        isAutoTrackingOn: false
    )

    @MainActor
    /// A sample trip
    static let spain = Trip(
        title: "Spain",
        startDate: Date.from(string: "2021/11/03 08:06:00"),
        endDate: Date.from(string: "2021/11/30 12:00:00"),
        isAutoTrackingOn: false
    )
}
