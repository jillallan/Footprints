////
////  EqualWidthHStack.swift
////  Footprints
////
////  Created by Jill Allan on 30/12/2023.
////
//
//import Foundation
//import SwiftUI
//
//struct EqualWidthHStack: Layout {
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        let maxSize = maxSize(subviews: subviews)
//        let spacing = spacing(subviews: subviews)
//    }
//    
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        // TODO: fhfh
//    }
//    
//    func maxSize(subviews: Subviews) -> CGSize {
//        let subviewSizes = subviews.map { subview in
//            subview.sizeThatFits(.unspecified)
//        }
//        let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
//            CGSize(
//                width: max(currentMax.width, subviewSize.width),
//                height: max(currentMax.height, subviewSize.height))
//        }
//    }
//    
//    func spacing(subviews: Subviews) -> CGFloat {
//        
//        let spacing = subviews.indices.map { index in
//            guard index < subviews.count - 1 else {
//                return 0.0
//            }
//
//            return subviews[index].spacing.distance(
//                to: subviews[index + 1].spacing,
//                along: .horizontal)
//        }
//    }
//}
