//
//  CustomSheet.swift
//  Footprints
//
//  Created by Jill Allan on 14/02/2024.
//

#if os(iOS)

import PhotosUI
import SwiftUI

struct CustomSheet<Content>: UIViewRepresentable where Content: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let detents: [UISheetPresentationController.Detent]
    let content: Content
    
    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        detents: [UISheetPresentationController.Detent] = [.medium()],
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.detents = detents
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let viewController = UIViewController()
        let hostingViewController = UIHostingController(rootView: content)
        
        viewController.addChild(hostingViewController)
        viewController.view.addSubview(hostingViewController.view)
        
//        viewController.view.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
        
        // Set constraints
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.leftAnchor.constraint(equalTo: viewController.view.leftAnchor).isActive = true
        hostingViewController.view.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
        hostingViewController.view.rightAnchor.constraint(equalTo: viewController.view.rightAnchor).isActive = true
        hostingViewController.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true
        hostingViewController.didMove(toParent: viewController)
        
        if let sheetController = viewController.presentationController as? UISheetPresentationController {
            sheetController.detents = detents
            sheetController.prefersGrabberVisible = true
            sheetController.prefersScrollingExpandsWhenScrolledToEdge = true
            sheetController.largestUndimmedDetentIdentifier = .medium
            sheetController.widthFollowsPreferredContentSizeWhenEdgeAttached = true
//            sheetController.sourceView = hostingViewController.view
        }
        
        viewController.presentationController?.delegate = context.coordinator
        
        if isPresented {
            uiView.window?.rootViewController?.present(viewController, animated: true)
        } else {
            uiView.window?.rootViewController?.dismiss(animated: true)
        }
    }
    
    typealias UIViewType = UIView
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, onDismiss: onDismiss)
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        @Binding var isPresented: Bool
        let onDismiss: (() -> Void)?
        
        init(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil) {
            self._isPresented = isPresented
            self.onDismiss = onDismiss
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            isPresented = false
            if let onDismiss = onDismiss {
                onDismiss()
            }
        }
    }
}
#endif
