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
    
    func getSize(_ size: Binding<CGSize>) -> some View {
        modifier(getSizeModifier(size: size))
    }
    
    func getAspectRatio(_ aspectRatio: Binding<AspectRatio>) -> some View {
        modifier(getAspectRatioModifier(aspectRatio: aspectRatio))
    }
    
    func setAspectRatio(_ aspectRatio: AspectRatio) -> some View {
        let _ = print("Aspect ratio set: \(aspectRatio)")
        return environment(\.aspectRatio, aspectRatio)
    }
    
    func dynamicSafeAreaInset<V>(
        edge: Edge,
        @ViewBuilder content: @escaping () -> V
    ) -> some View where V : View {
        modifier(DynamicSafeAreaInsetModifier(edge: edge, viewContent: content))
        
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
         if condition {
             transform(self)
         } else {
             self
         }
     }
}

extension View {
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func tvOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(tvOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func watchOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(watchOS)
        return modifier(self)
        #else
        return self
        #endif
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

struct getSizeModifier: ViewModifier {
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
                            print("Aspect ratio: \(ratio)")
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


