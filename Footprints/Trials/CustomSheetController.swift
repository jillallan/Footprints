//
//  CustomSheetController.swift
//  Footprints
//
//  Created by Jill Allan on 17/02/2024.
//

import Foundation
import SwiftUI

struct CustomSheetController<Content: View>: UIViewControllerRepresentable {
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
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            if uiViewController.presentedViewController == nil {
                let hostingViewController = UIHostingController(rootView: content)
                
                uiViewController.addChild(hostingViewController)
                uiViewController.view.addSubview(hostingViewController.view)
                
        //        viewController.view.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
                
                // Set constraints
                hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
                hostingViewController.view.leftAnchor.constraint(equalTo: uiViewController.view.leftAnchor).isActive = true
                hostingViewController.view.topAnchor.constraint(equalTo: uiViewController.view.topAnchor).isActive = true
                hostingViewController.view.rightAnchor.constraint(equalTo: uiViewController.view.rightAnchor).isActive = true
                hostingViewController.view.bottomAnchor.constraint(equalTo: uiViewController.view.bottomAnchor).isActive = true
                hostingViewController.didMove(toParent: uiViewController)
                
                if let sheetController = uiViewController.presentationController as? UISheetPresentationController {
                    sheetController.detents = detents
                    sheetController.prefersGrabberVisible = true
                    sheetController.prefersScrollingExpandsWhenScrolledToEdge = true
                    sheetController.largestUndimmedDetentIdentifier = .medium
                    sheetController.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        //            sheetController.sourceView = hostingViewController.view
                }
                
                uiViewController.presentationController?.delegate = context.coordinator
            }
        }
    }
    
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
