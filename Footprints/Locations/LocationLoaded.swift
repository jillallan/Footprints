//
//  LocationLoaded.swift
//  Footprints
//
//  Created by Jill Allan on 04/03/2024.
//

import SwiftUI

struct LocationLoaded: View {
    let locationName: String
    let alignment: HorizontalAlignment
    
    var body: some View {
        switch alignment {
        case .leading:
            HStack {
                Text(locationName)
                Spacer()
            }
        case .center:
            Text(locationName)

        case .trailing:
            HStack {
                Spacer()
                Text(locationName)
            }
        default:
            Text(locationName)
        }
    
        
    }
}

#Preview("Leading") {
    List {
        LocationLoaded(locationName: "Bedminster", alignment: .leading)
    }
}

#Preview("Center list view") {
    List {
        LocationLoaded(locationName: "Bedminster", alignment: .center)
    }
}

#Preview("Center") {
    LocationLoaded(locationName: "Bedminster", alignment: .center)
    
}

#Preview("Trailing") {
    List {
        LocationLoaded(locationName: "Bedminster", alignment: .trailing)
    }
}
