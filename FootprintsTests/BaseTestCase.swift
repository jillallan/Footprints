//
//  BaseTestCase.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/10/2023.
//

import SwiftData
import XCTest
@testable import Footprints

final class BaseTestCase: XCTestCase {
    var container: MockJournalDataContainer!
    var modelContext: ModelContext!

    override func setUpWithError() throws {
        container = MockJournalDataContainer(inMemory: true)
        modelContext = container.container.mainContext
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
