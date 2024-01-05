//
//  StepDetailViewTextEditor.swift
//  Footprints
//
//  Created by Jill Allan on 04/01/2024.
//

import MapKit
import SwiftUI

struct StepDetailViewTextEditor: View {
    @State private var text: String = "Hello"
    var body: some View {
        VStack {
            TextEditor(text: $text)
            LazyVStack {

                ForEach(0..<4) {_ in
                    Image(.beach)
                        .resizable()
                        .scaledToFit()
                    
                }

            }
        
        }
        .safeAreaInset(edge: .top) {
            Map()
                .frame(height: 100)
        }
    }
}

#Preview {
    StepDetailViewTextEditor()
}
