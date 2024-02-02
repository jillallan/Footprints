//
//  GetSizeModifier.swift
//  Footprints
//
//  Created by Jill Allan on 01/02/2024.
//


// fatbobman

import Foundation
import SwiftUI

struct GetSizeModifier: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    let proxySize = geometry.size
                    Color.clear
                        .task(id: geometry.size) {
                            let width = max(proxySize.width, 0)
                            let height = max(proxySize.height, 0)
                            $size.wrappedValue = CGSize(width: width, height: height)
                        }
                }
            )
    }
}
