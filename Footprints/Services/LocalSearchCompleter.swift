//
//  LocalSearchCompleter.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import Foundation
import MapKit
import SwiftUI

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
}

@Observable class LocalSearchCompleter: NSObject {
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
      
        print(completer.results.first?.description ?? "no description")
        print(completer.results.first?.titleHighlightRanges ?? "no title ranges")
        print(completer.results.first?.subtitleHighlightRanges ?? "no subtitle ranges")
        print(completer.results.first?.title ?? "no title")
        print(completer.results.first?.subtitle ?? "no subtitle")
        completions = completer.results.map {.init(title: $0.title, subTitle: $0.subtitle) }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // TODO: comment
    }
}
