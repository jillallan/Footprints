//
//  SizeClass.swift
//  Footprints
//
//  Created by Jill Allan on 30/08/2024.
//

import SwiftUI

struct SizeClass: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        VStack {
//            Text(horizontalSizeClass.description)
            Text(horizontalSizeClass.debugDescription)
            Text(verticalSizeClass.debugDescription)
        }
    }
}

#Preview {
    SizeClass()
}
