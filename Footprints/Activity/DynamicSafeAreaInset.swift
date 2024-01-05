//
//  DynamicSafeAreaInset2.swift
//  Footprints
//
//  Created by Jill Allan on 26/12/2023.
//

import MapKit
import SwiftUI

struct DynamicSafeAreaInset<Content: View>: View {
    @State private var size: CGSize = .zero
    @ViewBuilder let content: Content
    
//    var horizontalScrollHeight: Double {
        // Round height up, otherwise in some cases the scroll view is bigger than the scroll heigth calculated here
//        ceil(size.width / (cardAspectRatio * Double(scrollItemCount)))
//    }
    
//    var verticalScrollWidth: Double {
        // Round width up, otherwise in some cases the scroll view is bigger than the scroll width calculated here
//        ceil(size.height * (cardAspectRatio / Double(scrollItemCount)))
//    }
    
    var body: some View {
        VStack {
            content
        }
        .getSize($size)
    }
}

#Preview {
    Map()
        .dynamicSafeAreaInset(edge: .bottom) {
            DynamicSafeAreaInset {
                Form {
                    Text("Hello")
                }
            }
        }
    
}
