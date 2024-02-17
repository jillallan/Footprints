//
//  SearchUIKit.swift
//  Footprints
//
//  Created by Jill Allan on 16/02/2024.
//

#if os(iOS)
import Foundation
import MapKit
import SwiftUI
//import UIKit

struct SearchUIKit: UIViewControllerRepresentable {
    let searchResults: [MKMapItem] = []
    
    func makeUIViewController(context: Context) -> UISearchController {
        
        let searchResultsController = UIHostingController(rootView: SearchResults(searchResults: searchResults))
        let searchController = UISearchController(searchResultsController: searchResultsController)
        
        return searchController
    }
    
    func updateUIViewController(_ uiViewController: UISearchController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UISearchController
    
    
}
#endif
