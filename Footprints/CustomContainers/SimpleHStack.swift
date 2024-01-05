//
//  SimpleHStack.swift
//  Footprints
//
//  Created by Jill Allan on 29/12/2023.
//

import Foundation
import SwiftUI

struct SimpleHStack: Layout {
    let spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let idealViewSizes = subviews.map { subview in
            subview.sizeThatFits(.unspecified)
        }
        let spacing = spacing * CGFloat(subviews.count - 1)
        let width = spacing + idealViewSizes.reduce(0) { $0 + $1.width }
        let height = idealViewSizes.reduce(0) { max($0, $1.height) }
        
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var pt = CGPoint(x: bounds.minX, y: bounds.minY)
        
        let sortedViews = subviews.sorted { v1, v2 in
            v1[PreferredPosition.self] > v2[PreferredPosition.self]
        }
        
        for subview in sortedViews {
            subview.place(at: pt, anchor: .topLeading, proposal: .unspecified)
            
            pt.x += subview.sizeThatFits(.unspecified).width + spacing
        }
    }
    
    func explicitAlignment(of guide: HorizontalAlignment, in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGFloat? {
        if guide == .leading {
            return subviews[0].sizeThatFits(proposal).width + spacing
        } else {
            return nil
        }
    }
}

struct PreferredPosition: LayoutValueKey {
    static var defaultValue: CGFloat = 0.0
    
    
}
