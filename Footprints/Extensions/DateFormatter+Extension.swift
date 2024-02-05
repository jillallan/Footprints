//
//  DateFormatter+Extension.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import Foundation

extension DateFormatter {
    static let defaultDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static func date(fromDefault string: String) -> Date {
        return DateFormatter.defaultDateFormat.date(from: string) ?? Date.now
    }
    

    static let dayOrdinal_dd: DateFormatter = {
        let df = DateFormatter()
        let localeIdentifier = NSLocale.current.identifier
        df.locale = Locale(identifier: localeIdentifier)
        df.setLocalizedDateFormatFromTemplate("dd")
        df.locale = Locale.autoupdatingCurrent
        
        return df
    }()
    
    static let dayOrdinal_d: DateFormatter = {
        let df = DateFormatter()
        let localeIdentifier = NSLocale.current.identifier
        df.locale = Locale(identifier: localeIdentifier)
        df.setLocalizedDateFormatFromTemplate("dd")
        df.locale = Locale.autoupdatingCurrent
        
        return df
    }()
    
    static let monthLong: DateFormatter = {
        let df = DateFormatter()
        let localeIdentifier = NSLocale.current.identifier
        df.locale = Locale(identifier: localeIdentifier)
        df.setLocalizedDateFormatFromTemplate("MMMM")
        df.locale = Locale.autoupdatingCurrent
        
        return df
    }()
    
    static let year: DateFormatter = {
        let df = DateFormatter()
        let localeIdentifier = NSLocale.current.identifier
        df.locale = Locale(identifier: localeIdentifier)
        df.setLocalizedDateFormatFromTemplate("yyyy")
        df.locale = Locale.autoupdatingCurrent
        
        return df
    }()
}
