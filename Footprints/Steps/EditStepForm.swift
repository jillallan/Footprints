//
//  EditStepForm.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct EmptyNameView: View {
    var body: some View {
        Text("New Step")
    }
}
    
struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    let placemarkName: String
    
    var body: some View {
        Text(placemarkName)
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}
    
    




