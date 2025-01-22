//
//  Helpers.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/20/25.
//

import Foundation
import SwiftUI

var textColor: Color {
    Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
    })
}

func lengthToString(length: Double) -> String {
    let hours = Int(length) / 3600
    let minutes = (Int(length) % 3600) / 60
    let seconds = Int(length) % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}
