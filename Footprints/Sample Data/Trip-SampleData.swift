//
//  Trip-SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

import Foundation

extension Trip {
    static let bedminsterToBeijing = Trip(
        title: "Bedminster to Beijing",
        startDate: Date.from(string: "2016/07/28 08:06:00"),
        endDate: Date.from(string: "2016/09/02 12:00:00"),
        isAutoTrackingOn: false
    )
    
    static let mountains = Trip(
        title: "Mountains",
        startDate: Date.from(string: "2016/09/03 08:06:00"),
        endDate: Date.from(string: "2016/09/30 12:00:00"),
        isAutoTrackingOn: false
    )
}
