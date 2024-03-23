//
//  View+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 10/11/2023.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func getSize(_ size: Binding<CGSize>) -> some View {
        modifier(GetSizeModifier(size: size))
    }
    
    func getAspectRatio(_ aspectRatio: Binding<AspectRatio>) -> some View {
        modifier(getAspectRatioModifier(aspectRatio: aspectRatio))
    }
    
    func setAspectRatio(_ aspectRatio: AspectRatio) -> some View {
//        let _ = print("Aspect ratio set: \(aspectRatio)")
        return environment(\.aspectRatio, aspectRatio)
    }
    
    func dynamicSafeAreaInset<V>(
        edge: Edge,
        @ViewBuilder content: @escaping () -> V
    ) -> some View where V : View {
        modifier(DynamicSafeAreaInsetModifier(edge: edge, viewContent: content))
    }
    
    func onChange<Value>(
        of value: Value,
        debounceTime delayInterval: TimeInterval,
        perform action: @escaping (_ newValue: Value) -> Void
    ) -> some View where Value: Equatable {
        modifier(DebouncedOnChangeViewModifier(trigger: value, action: action) {
            try await Task.sleep(nanoseconds: UInt64(delayInterval * 1_000_000_000))
        })
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
