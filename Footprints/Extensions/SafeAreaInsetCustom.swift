//
//  SafeAreaInsetCustom.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2023.
//

import SwiftUI

enum EdgeCustom {
    case top, bottom, leading, trailing
}

//struct SafeAreaInsetCustomModifier: ViewModifier {
//    func body(content: Content) -> Content {
//        SafeAreaInsetCustom(edge: EdgeCustom, content: )
//    }
//}

struct SafeAreaInsetCustom: ViewModifier {
    let edge: EdgeCustom
    let contentClosure: () -> Content
    
    var verticleEdge: VerticalEdge? {
        switch edge {
        case .top:
            return VerticalEdge.top
        case .bottom:
            return VerticalEdge.bottom
        default:
            return nil
        }
    }
    
    var horizontalEdge: HorizontalEdge? {
        switch edge {
        case .leading:
            return HorizontalEdge.leading
        case .trailing:
            return HorizontalEdge.trailing
        default:
            return nil
        }
    }
    
    func body(content: Content) -> some View {
        if (verticleEdge != nil) {
            content.safeAreaInset(edge: verticleEdge ?? .top) {
                contentClosure()
            }
        } else if (horizontalEdge != nil) {
            content.safeAreaInset(edge: horizontalEdge ?? .leading) {
                contentClosure()
            }
        }
    }
    
//    var body: some View {
//        switch edge {
//        case .top, .bottom:
//            safeAreaInset(edge: verticleEdge ?? .top) {
//                content()
//            }
//        case .leading, .trailing:
//            safeAreaInset(edge: horizontalEdge ?? .leading) {
//                content()
//            }
//            
//        }
//    }
}
