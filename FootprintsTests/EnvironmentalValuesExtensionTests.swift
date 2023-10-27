//
//  FootprintsTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/10/2023.
//

import XCTest
@testable import Footprints

final class EnvironmentalValuesExtensionTests: XCTestCase {
    func testPrefersTabNavigationEnvironmentKey_whenPhoneOrTV_shouldReturnTrue() throws {
#if os(iOS)
        let userInterfaceIdioms = [
            "phone": UITraitCollection.init(userInterfaceIdiom: .phone),
            "tv": UITraitCollection.init(userInterfaceIdiom: .tv)
        ]
        
        for (key, value) in userInterfaceIdioms {
            let prefersTabNavigation = PrefersTabNavigationEnvironmentKey.read(from: value)
            XCTAssertTrue(prefersTabNavigation, "Should return true if \(key)")
        }
#endif
    }
    
    func testPrefersTabNavigationEnvironmentKey_whenNotPhoneOrTV_shouldReturnFalse() throws {
#if os(iOS)
        let userInterfaceIdioms = [
            "pad": UITraitCollection.init(userInterfaceIdiom: .pad),
            "carPlay": UITraitCollection.init(userInterfaceIdiom: .carPlay),
            "mac": UITraitCollection.init(userInterfaceIdiom: .mac),
            "unspecified": UITraitCollection.init(userInterfaceIdiom: .unspecified),
            "vision": UITraitCollection.init(userInterfaceIdiom: .vision),
        ]
        
        for (key, value) in userInterfaceIdioms {
            let prefersTabNavigation = PrefersTabNavigationEnvironmentKey.read(from: value)
            XCTAssertFalse(prefersTabNavigation, "Should return false if \(key)")
        }
#endif
    }
}
