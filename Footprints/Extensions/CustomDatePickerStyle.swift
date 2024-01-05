//
//  CustomDatePickerStyle.swift
//  Footprints
//
//  Created by Jill Allan on 26/12/2023.
//

import SwiftUI

struct CustomDatePickerStyle: DatePickerStyle {

    
//    @State private var currentDate = Date()
    
    func makeBody(configuration: Configuration) -> some View {
        
        HStack {
            configuration.label
                .font(.headline)
//                .padding()
//                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))

        }
    }
}

