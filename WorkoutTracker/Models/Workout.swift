//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import Foundation
import SwiftData

@Model
class Workout {
    var name: String
    var exercises: [WorkoutExercise]
    
    init(name: String = "", exercises: [WorkoutExercise] = []) {
        self.name = name
        self.exercises = exercises
    }
}

@Model
class ExerciseSet {
    var reps: Int
    var weight: Double
    
    init(reps: Int, weight: Double) {
        self.reps = reps
        self.weight = weight
    }
}

@Model
class WorkoutExercise {
    var exercise: Exercise
    var sets: [ExerciseSet]
    
    init(exercise: Exercise, sets: [ExerciseSet]) {
        self.exercise = exercise
        self.sets = sets
    }
}
