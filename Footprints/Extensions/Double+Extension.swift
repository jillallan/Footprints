//
//  Double+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 27/09/2024.
//

import Foundation

extension Double {
    static func range(of doubles: [Double]) -> Self? {
        let min = doubles.min()
        let max = doubles.max()

        if let min,
            let max {
            return max - min
        } else {
            return nil
        }
    }
}
