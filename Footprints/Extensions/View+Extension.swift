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
