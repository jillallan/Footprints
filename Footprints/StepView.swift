//
//  StepView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftData
import SwiftUI

struct StepView: View {
    @Query var steps: [Step]
    @State var scrollPositionID: PersistentIdentifier?
    
    var body: some View {
        VStack {
            Text(String(describing: scrollPositionID))
            ScrollView {
                LazyVStack {
                    ForEach(steps) { step in
                        Text(step.timestamp, style: .time)
                            .padding(20)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollPositionID)
        }
    }
}

#Preview {
    StepView()
}
