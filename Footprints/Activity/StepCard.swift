//
//  StepCard.swift
//  Footprints
//
//  Created by Jill Allan on 12/11/2023.
//

import SwiftUI

struct StepCard: View {
    let image: Image
    
    var body: some View {
        image
//        Image(uiImage: image)
            .resizable()
        
        
    }
}

#Preview {
    StepCard(image: Image(.beach))
}
