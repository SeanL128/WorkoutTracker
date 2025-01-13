//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import Foundation
import SwiftData

@Model
class Exercise {
    var movement: Movement
    var exerciseSets: [ExerciseSet]   // Reps, Weight
    
    init(movement: Movement = Movement(), sets: [ExerciseSet] = []) {
        self.movement = movement
        self.exerciseSets = sets
    }
}

struct ExerciseSet: Codable {
    var reps: Int {
        didSet {
            if reps < 0 { reps = 0 }
        }
    }
    var weight: Double {
        didSet {
            if weight < 0 { weight = 0 }
        }
    }
    
    init(reps: Int = 0, weight: Double = 0) {
        self.reps = max(0, reps)
        self.weight = max(0, weight)
    }
}
