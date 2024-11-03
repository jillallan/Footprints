//
//  ModelContext+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 01/11/2024.
//

import Foundation
import SwiftData

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
