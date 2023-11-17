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
    
    func getAspectRatio(_ aspectRatio: Binding<AspectRatioTest>) -> some View {
        modifier(getAspectRatioModifier(aspectRatio: aspectRatio))
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

enum AspectRatioTest {
    case wide(aspectRatio: Double)
    case landscape(aspectRatio: Double)
    case square(aspectRatio: Double)
    case portrait(aspectRatio: Double)
    case tall(aspectRatio: Double)
    case zero(AspectRatio: Double)
}

enum AspectRatio {
    case wide, landscape, square, portrait, tall
}

struct getAspectRatioModifier: ViewModifier {
    @Binding var aspectRatio: AspectRatioTest
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    let proxySize = geometry.size
                    Color.clear
                        .task(id: geometry.size) {
                            let ratio = max(proxySize.width, 0) / max(proxySize.height, 0) 
                            switch ratio {
                            case 1.5...:
                                $aspectRatio.wrappedValue = AspectRatioTest.wide(aspectRatio: ratio)
                            case 1.1..<1.5:
                                $aspectRatio.wrappedValue = AspectRatioTest.landscape(aspectRatio: ratio)
                            case 0.9..<1.1:
                                $aspectRatio.wrappedValue = AspectRatioTest.square(aspectRatio: ratio)
                            case 0.75..<0.9:
                                $aspectRatio.wrappedValue = AspectRatioTest.portrait(aspectRatio: ratio)
                            case ..<0.75:
                                $aspectRatio.wrappedValue = AspectRatioTest.tall(aspectRatio: ratio)
                            default:
                                $aspectRatio.wrappedValue = AspectRatioTest.square(aspectRatio: ratio)
                                
                            }
                        }
                }
            )
    }
}


