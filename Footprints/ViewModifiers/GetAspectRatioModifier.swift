//
//  GetAspectRatioModifier.swift
//  Footprints
//
//  Created by Jill Allan on 01/02/2024.
//
// fatbobman

import Foundation
import SwiftUI

enum AspectRatio {
    case wide(aspectRatio: Double)
    case landscape(aspectRatio: Double)
    case square(aspectRatio: Double)
    case portrait(aspectRatio: Double)
    case tall(aspectRatio: Double)
    case zero(AspectRatio: Double)
}

struct getAspectRatioModifier: ViewModifier {
    @Binding var aspectRatio: AspectRatio
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    let proxySize = geometry.size
                    Color.clear
                        .task(id: geometry.size) {
                            let ratio = max(proxySize.width, 0) / max(proxySize.height, 0)
//                            print("Aspect ratio: \(ratio)")
                            switch ratio {
                            case 2.1...:
                                $aspectRatio.wrappedValue = AspectRatio.wide(aspectRatio: ratio)
                            case 1.6..<2.1:
                                $aspectRatio.wrappedValue = AspectRatio.landscape(aspectRatio: ratio)
                            case 0.9..<1.6:
                                $aspectRatio.wrappedValue = AspectRatio.square(aspectRatio: ratio)
                            case 0.75..<0.9:
                                $aspectRatio.wrappedValue = AspectRatio.portrait(aspectRatio: ratio)
                            case ..<0.75:
                                $aspectRatio.wrappedValue = AspectRatio.tall(aspectRatio: ratio)
                            default:
                                $aspectRatio.wrappedValue = AspectRatio.square(aspectRatio: ratio)
                                
                            }
                        }
                }
            )
    }
}
