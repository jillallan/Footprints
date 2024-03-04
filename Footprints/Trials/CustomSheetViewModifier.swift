//
//  CustomSheetViewModifier.swift
//  Footprints
//
//  Created by Jill Allan on 14/02/2024.
//

#if os(iOS)
import SwiftUI

struct CustomSheetViewModifier<SwiftUIContent>: ViewModifier where SwiftUIContent: View {
    @Binding var isPresented: Bool
        let onDismiss: (() -> Void)?
        let detents: [UISheetPresentationController.Detent]
        let swiftUIContent: SwiftUIContent
        
        init(
            isPresented: Binding<Bool>,
            detents: [UISheetPresentationController.Detent] = [.medium()],
            onDismiss: (() -> Void)? = nil,
            content: () -> SwiftUIContent
        ) {
            self._isPresented = isPresented
            self.onDismiss = onDismiss
            self.swiftUIContent = content()
            self.detents = detents
        }
        
        func body(content: Content) -> some View {
            ZStack {
                CustomSheet(isPresented: $isPresented, onDismiss: onDismiss, detents: detents) {
                    swiftUIContent
                }.fixedSize()
                content
            }
        }
}

extension View {
    
    func customSheet<Content>(
        isPresented: Binding<Bool>,
        detents: [UISheetPresentationController.Detent],
        onDismiss: (() -> Void)?,
        content: @escaping () -> Content) -> some View where Content : View {
            modifier(
                CustomSheetViewModifier(
                    isPresented: isPresented,
                    detents: detents,
                    onDismiss: onDismiss,
                    content: content)
            )
        }
}
#endif
