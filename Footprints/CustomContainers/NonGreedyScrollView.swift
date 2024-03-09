//
//  NonGreedyVStack.swift
//  Footprints
//
//  Created by Jill Allan on 30/12/2023.
//

import Foundation
import SwiftUI
    
struct NonGreedyScrollView: Layout {
    static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .vertical
        
        return properties
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // Get subview sizes
        let subviewSizes = subviews.map { subview in
            print("Ideal size: \(subview.sizeThatFits(.unspecified))")
            print("Min size: \(subview.sizeThatFits(.zero))")
            print("Max size: \(subview.sizeThatFits(.infinity))")
            return subview.sizeThatFits(.unspecified)
//            return proposal
            
        }
        
        return CGSize(
            width: subviewSizes.map(\.width).reduce(0, +),
            height: subviewSizes.map(\.height).reduce(0, +))
        
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
       
    }
    
    
}
