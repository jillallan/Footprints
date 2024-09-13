//
//  EnvironmentValues+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 13/09/2024.
//

import Foundation
import SwiftUI

#if swift(>=6.0)
    #warning("Reevaluate whether this nonisolated(unsafe) decoration on keys is necessary.")
#endif

enum OSType {
    case iOS, macOS, watchOS
}

extension EnvironmentValues {

    /// An environment key indicating if the device prefers tab navigation
    ///
    /// This is used to apply the tab bar navigation on iPhone and TV platforms.
    /// Otherwise split view navigation is used
    var deviceType: DeviceType {
        get { self[DeviceIdiomEnvironmentKey.self] }
        set { self[DeviceIdiomEnvironmentKey.self] = newValue }
    }
}

enum DeviceType: Equatable {
    case phone, pad, tv, watch, mac, vision, unspecified
}

/// The default navigation is split view navigation
struct DeviceIdiomEnvironmentKey: EnvironmentKey {
    nonisolated(unsafe) static var defaultValue: DeviceType = .mac
}

#if os(iOS)

extension DeviceTypeEnvironmentKey: UITraitBridgedEnvironmentKey {

    /// Reads the user interface idiom from the current UITraitCollection.
    /// Required by the UITraitBridgedEnvironmentKey protocol
    /// - Parameter traitCollection: UITraitCollection of the device
    /// - Returns: True if the device is an iphone or tv, false for all other platforms
    static func read(from traitCollection: UITraitCollection) -> DeviceType {
        switch traitCollection.userInterfaceIdiom {
        case .phone:
            return DeviceType.phone
        case .pad:
            return DeviceType.pad
        case .watch:
            return DeviceType.watch
        case .tv:
            return DeviceType.tv
        case .vision:
            return DeviceType.vision
        default:
            DeviceType.unspecified
        }
        return traitCollection.userInterfaceIdiom
    }

    /// Required by the UITraitBridgedEnvironmentKey protocol
    /// - Parameters:
    ///   - mutableTraits: UIMutableTraits
    ///   - value: Bool
    ///
    ///   Writes the user interface idiom to the current UITraitCollection.
    ///   Not implemented for this extension
    static func write(to mutableTraits: inout UIMutableTraits, value: UIUserInterfaceIdiom) {
        // Do not write
    }
}
#endif
