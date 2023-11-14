//
//  View+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 10/11/2023.
//

import Foundation
import SwiftUI

extension View {
    func getWidth(_ width: Binding<CGFloat>) -> some View {
        modifier(getWidthModifier(width: width))
    }
    
    func getHeight(_ height: Binding<CGFloat>) -> some View {
        modifier(getHeightModifier(height: height))
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
         if condition {
             transform(self)
         } else {
             self
         }
     }
}

struct getWidthModifier: ViewModifier {
    @Binding var width: CGFloat
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    let proxyWidth = geometry.size.width
                    Color.clear
                        .task(id: geometry.size.width) {
                            $width.wrappedValue = max(proxyWidth, 0)
                        }
                }
            )
    }
}

struct getHeightModifier: ViewModifier {
    @Binding var height: CGFloat
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    let proxyHeight = geometry.size.height
                    Color.clear
                        .task(id: geometry.size.height) {
                            $height.wrappedValue = max(proxyHeight, 0)
                        }
                }
            )
    }
}
