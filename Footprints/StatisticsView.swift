//
//  StatisticsView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 5) {
                contents()
            }
            .border(.black)
            
//            SimpleHStack(spacing: 5) {
//                contents()
//            }
//            .border(.red)
            
            SimpleHStack(spacing: 5) {
                Circle().fill(.yellow)
                     .frame(width: 30, height: 30)
                                    
                Circle().fill(.green)
                    .frame(width: 30, height: 30)

                Circle().fill(.blue)
                    .frame(width: 30, height: 30)
//                    .layoutPriority(1)
                    .layoutValue(key: PreferredPosition.self, value: 1.0)
            }
            .border(.red)
            
            HStack(spacing: 5) {
                contents()
            }
            .border(.black)
            
        }
        .background { Rectangle().stroke(.green) }
        .padding()
        .font(.largeTitle)
        
    }
    
    @ViewBuilder func contents() -> some View {
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundColor(.accentColor)
        Text("Hello, world!")
    }
}

#Preview {
    StatisticsView()
}
