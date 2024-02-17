//
//  NavigationUIKit.swift
//  Footprints
//
//  Created by Jill Allan on 16/02/2024.
//
#if os(iOS)
import MapKit
import SwiftUI

import UIKit

struct NavigationUIKit: UIViewControllerRepresentable {
    let searchResults: [MKMapItem] = []
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController()
        let searchResultsController = UIHostingController(rootView: SearchResults(searchResults: searchResults))
        let searchController = UISearchController(searchResultsController: searchResultsController)
        navigationController.navigationItem.searchController = searchController
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UINavigationController
    
    
}
#endif
