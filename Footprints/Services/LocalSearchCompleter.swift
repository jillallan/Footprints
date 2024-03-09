//
//  LocalSearchCompleter.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import Foundation
import MapKit
import OSLog
import SwiftUI

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
}

@Observable class LocalSearchCompleter: NSObject {
    
    private let logger = Logger(category: String(describing: LocalSearchCompleter.self))
    
    var completions = [SearchCompletions]()
    let completer = MKLocalSearchCompleter()

    
    override init() {
        super.init()
        completer.delegate = self
    }
    
    func search(for query: String, in region: MKCoordinateRegion) {
        completer.region = region
        completer.queryFragment = query
    }
}

extension LocalSearchCompleter: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
      
        logger.debug("\(#function) : \(#line) : String(describing: completer.results.first?.description)")
        logger.debug("\(#function) : \(#line) : String(describing: completer.results.first?.titleHighlightRanges)")
        logger.debug("\(#function) : \(#line) : String(describing: completer.results.first?.subtitleHighlightRanges)")
        logger.debug("\(#function) : \(#line) : String(describing: completer.results.first?.title)")
        logger.debug("\(#function) : \(#line) : String(describing: completer.results.first?.subtitle)")
        completions = completer.results.map {.init(title: $0.title, subTitle: $0.subtitle) }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {

    }
}
