//
//  AppDetailColumn.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftUI

struct AppDetailColumn: View {
    var screen: AppScreen?

    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView(
                    "Select a View",
                    systemImage: "airplane",
                    description: Text("Pick something from the list.")
                )
            }
        }
        .macOS { group in
            group
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
        }
//#if os(macOS)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background()
//#endif
        
    }
}

#Preview() {
    AppDetailColumn()
}
