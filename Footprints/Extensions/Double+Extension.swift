//
//  Double+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import Foundation

extension Double {
    static func midRange(of doubles: [Double]) -> Double? {
        let min = doubles.min()
        let max = doubles.max()
        
        if let min,
            let max {
            return (max - min) / 2
        } else {
            return nil
        }
    }
    
    static func range(of doubles: [Double]) -> Double? {
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
