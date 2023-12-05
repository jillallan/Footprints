//
//  AppTabView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?
    @State var aspectRatio: AspectRatio = .zero(AspectRatio: 0.0)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var body: some View {
        // TODO: Add button shapes if buttonShapesEnabled
        TabView(selection: $selection) {
            let _ = print("horizontalSizeClass: \(String(describing: horizontalSizeClass))")
            let _ = print("verticalSizeClass: \(String(describing: verticalSizeClass))")
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
                    .getAspectRatio($aspectRatio)
//                    .setAspectRatio(aspectRatio)
          
            }
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.trips))
}
