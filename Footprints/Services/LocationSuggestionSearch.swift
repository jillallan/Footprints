//
//  LocationSearchService.swift
//  Footprints
//
//  Created by Jill Allan on 10/10/2024.
//



import Foundation
import MapKit
import OSLog

@MainActor
final class LocationSuggestionSearch: NSObject {
    private let searchLogging = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Search Completions")
    
    var completer: MKLocalSearchCompleter
    
    let (stream, continuation) = AsyncStream.makeStream(
        of: [MKLocalSearchCompletion].self,
        bufferingPolicy: .bufferingNewest(1)
    )
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
    }
    
    func fetchLocationSuggestions(for query: String, in region: MKCoordinateRegion? = nil) async throws -> [LocationSuggestion] {
        
        guard !query.isEmpty else {
            return []
        }

        completer.queryFragment = query
        if let region {
            completer.region = region
            searchLogging.debug("region: \(String(describing:region))")
        }
        
        for try await searchCompletions in stream {
            let locationSuggestions = searchCompletions.map { searchCompletion in
                LocationSuggestion(title: searchCompletion.title, subtitle: searchCompletion.subtitle)
            }
            return locationSuggestions
        }
        return []

    }
}

extension LocationSuggestionSearch: MKLocalSearchCompleterDelegate {
    nonisolated func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {

            let suggestedCompletions = completer.results
            continuation.yield(suggestedCompletions)
    }

    nonisolated func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        searchLogging.error("Search completion failed for query \"\(completer.queryFragment)\". Reason: \(error.localizedDescription)")
        
        Task {
            continuation.yield([])
        }
    }
}
