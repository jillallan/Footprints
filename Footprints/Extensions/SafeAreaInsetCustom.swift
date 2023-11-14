//
//  SafeAreaInsetCustom.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2023.
//

import SwiftUI

enum EdgeCustom {
    case top, bottom, leading, trailing
}

struct SafeAreaInsetCustom<Content: ViewModifier>: ViewModifier {
    let edge: EdgeCustom
    @ViewBuilder let content: () -> Content
    
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
    
    var body: some View {
        switch edge {
        case .top, .bottom:
            safeAreaInset(edge: verticleEdge ?? .top) {
                content()
            }
        case .leading, .trailing:
            safeAreaInset(edge: horizontalEdge ?? .leading) {
                content()
            }
            
        }
    }
}
