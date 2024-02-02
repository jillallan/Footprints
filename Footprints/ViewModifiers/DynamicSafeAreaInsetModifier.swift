//
//  SafeAreaInsetCustom.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2023.
//

import SwiftUI

enum Edge {
    case top, bottom, leading, trailing
}

struct DynamicSafeAreaInsetModifier<V: View>: ViewModifier {

    let edge: Edge
    let viewContent: () -> V
    
    func body(content: Content) -> some View {
        if (verticleEdge != nil) {
            content.safeAreaInset(edge: verticleEdge ?? .top) {
                viewContent()
            }
        } else if (horizontalEdge != nil) {
            content.safeAreaInset(edge: horizontalEdge ?? .leading) {
                viewContent()
            }
        }
    }
    
    var verticleEdge: VerticalEdge? {
        switch edge {
        case .top:
            return VerticalEdge.top
        case .bottom:
            return VerticalEdge.bottom
        default:
            return nil
        }
    }
    
    var horizontalEdge: HorizontalEdge? {
        switch edge {
        case .leading:
            return HorizontalEdge.leading
        case .trailing:
            return HorizontalEdge.trailing
        default:
            return nil
        }
    }
}
