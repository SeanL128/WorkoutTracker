//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import Foundation
import SwiftData

@Model
class Workout: Identifiable {
    @Attribute(.unique) var id = UUID()
    
    var name: String
    var exercises: [WorkoutExercise]
    var notes: String
    
    init(name: String = "Workout", exercises: [WorkoutExercise] = [], notes: String = "Notes") {
        self.name = name
        self.exercises = exercises
        self.notes = notes
    }
    
    func addWorkout(exercise: Exercise, sets: [ExerciseSet], restTime: TimeInterval) {
        exercises.append(WorkoutExercise(exercise: exercise, sets: sets, restTime: restTime))
    }
}
