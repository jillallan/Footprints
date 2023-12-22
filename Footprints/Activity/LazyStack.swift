//
//  LazyStack.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2023.
//

import SwiftUI

struct LazyStack<Content: View>: View {
    let axes: Axis.Set
    @ViewBuilder let content: () -> Content
    
    // Add scrollTargetLayout here to enable scroll position id
    // Does not work by applying it to this view as a whole
    
    var body: some View {
        if axes == .horizontal {
            LazyHStack(spacing: 0.0) {
                content()
            }
            .scrollTargetLayout()
            
        } else if axes == .vertical {
            LazyVStack(spacing: 0.0) {
                content()
            }
            .scrollTargetLayout()
    
        }
    }
}
