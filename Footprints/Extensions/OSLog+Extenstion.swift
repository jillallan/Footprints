//
//  OSLog+Extenstion.swift
//  Footprints
//
//  Created by Jill Allan on 08/03/2024.
//

import Foundation
import OSLog

extension Logger {
    init(category: String) {
        self.init(subsystem: Bundle.main.bundleIdentifier!, category: category)
    }
    
    func debugCustom(
        _ message: String,
//        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        debug("(\(function) : \(line) : \(message, privacy: .public))")
    }
}

//struct LoggerExample {
//    private let logger = Logger(category: String(describing: LoggerExample.self))
//    
//    private let exampleString = "Hello debugger"
//    
//    func exampleFunction() {
//        logger.debugCustom("text: \(exampleString)")
//    }
//}
