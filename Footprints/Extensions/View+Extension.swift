//
//  View+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 06/09/2024.
//

import Foundation
import SwiftUI

extension View {
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    ///
    /// Example
    /// ```swift
    /// Text("Hello world!")
    ///     .if(true) { view in
    ///         view
    ///             .padding()
    ///     }
    /// ```
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    func mapDetailPresentationStyle() -> some View {
        modifier(MapDetailPresentation())
    }
}
