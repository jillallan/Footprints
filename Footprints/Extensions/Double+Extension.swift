//
//  Double+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import Foundation
import OSLog

extension Double {
    static let logger = Logger(category: String(describing: Double.self))
    
    static func midRange(of doubles: [Double]) -> Double? {
        logger.debug("\(String(describing: doubles))")
        
        let min = doubles.min()
        let max = doubles.max()
        
        logger.debug("min: \(String(describing: min)) & max: \(String(describing: max))")
        
        if let min,
            let max {
            logger.debug("\(String(describing: (max - min) / 2))")
            return min + (max - min) / 2
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
