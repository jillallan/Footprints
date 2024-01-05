//
//  MapWithLazyScrollView.swift
//  Footprints
//
//  Created by Jill Allan on 26/12/2023.
//

import MapKit
import SwiftUI

struct DynamicSafeAreaInsetOld<Content: View, SafeAreaContent: View>: View {
    @ViewBuilder let content: Content
    @ViewBuilder let safeAreaContent: SafeAreaContent
    @State var aspectRatio: AspectRatio = .zero(AspectRatio: 0.0)
    
    var body: some View {
        VStack {
            content
                .dynamicSafeAreaInset(edge: scrollEdge) {
                    safeAreaContent
                }
        }
        .getAspectRatio($aspectRatio)
    }
    
    var scrollEdge: Edge {
        switch aspectRatio {
        case .wide(_), .landscape(_):
            return .leading
        case .square(_), .portrait(_), .tall(_), .zero(_):
            return .bottom
        }
    }
    
    var verticleEdge: VerticalEdge? {
        switch scrollEdge {
        case .top:
            return VerticalEdge.top
        case .bottom:
            return VerticalEdge.bottom
        default:
            return nil
        }
    }
    
    var horizontalEdge: HorizontalEdge? {
        switch scrollEdge {
        case .leading:
            return HorizontalEdge.leading
        case .trailing:
            return HorizontalEdge.trailing
        default:
            return nil
        }
    }
}

#Preview {
    DynamicSafeAreaInsetOld {
        List {
            Text("1")
            Text("2")
            Text("3")
        }
    } safeAreaContent: {
        Text("Hello")
    }
}
