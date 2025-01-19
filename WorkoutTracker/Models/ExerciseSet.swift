//
//  ExerciseSet.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/17/25.
//

import Foundation
import SwiftData

@Model
class ExerciseSet: Identifiable {
    @Attribute(.unique) var id = UUID()
    
    var reps: Int
    var weight: Double
    var measurement: String
    var type: String
    var rir: Int
    
    init(reps: Int = 12, weight: Double = 40, measurement: String = "x", type: String = "Main", rir: Int = 0) {
        self.reps = reps
        self.weight = weight
        self.measurement = measurement
        self.type = type
        self.rir = rir
    }
}
