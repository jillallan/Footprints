//
//  String+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 31/10/2024.
//

import Foundation

extension String {
    static func getLastSubstring(from input: String) -> String? {
        let components = input.split(whereSeparator: { $0.isUppercase }).map(String.init)
        return components.last
    }
    
    func getLastSubstring() -> String? {
        return Self.getLastSubstring(from: self)
    }
}
