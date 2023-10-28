//
//  BaseTestCase.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/10/2023.
//

import SwiftData
import XCTest
@testable import Footprints

class BaseTestCase: XCTestCase {
    var container: MockDataContainer!
    var modelContext: ModelContext!

    @MainActor override func setUpWithError() throws {
        container = MockDataContainer(inMemory: true)
        modelContext = container.container.mainContext
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
