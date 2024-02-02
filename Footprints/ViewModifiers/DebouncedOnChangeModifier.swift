//
//  DebouncedOnChangeModifier.swift
//  Footprints
//
//  Created by Jill Allan on 01/02/2024.
//

import Foundation
import SwiftUI

// https://github.com/Tunous/DebouncedOnChange/blob/main/Sources/DebouncedOnChange/DebouncedChangeViewModifier.swift

struct DebouncedOnChangeViewModifier<Value>: ViewModifier where Value: Equatable {
    let trigger: Value
    let action: (Value) -> Void
    let sleep: @Sendable () async throws -> Void

    @State private var debouncedTask: Task<Void, Never>?

    func body(content: Content) -> some View {
        content.onChange(of: trigger) {
            debouncedTask?.cancel()
            debouncedTask = Task {
                do {
                    try await sleep()
                    action(trigger)
                } catch {
                    return
                }
            }
        }
    }
}
