//
//  StepCard.swift
//  Footprints
//
//  Created by Jill Allan on 12/11/2023.
//

import SwiftUI

struct StepCard: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
    }
}

#Preview {
    StepCard(image: UIImage(resource: .beach))
}
