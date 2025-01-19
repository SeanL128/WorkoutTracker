//
//  WorkoutExercise.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/17/25.
//

import Foundation
import SwiftData

@Model
class WorkoutExercise: Identifiable {
    @Attribute(.unique) var id = UUID()
    
    var exercise: Exercise?
    var sets: [ExerciseSet]
    var restTime: TimeInterval
    var specNotes: String
    var tempo: String
    
    init(exercise: Exercise? = nil, sets: [ExerciseSet] = [], restTime: TimeInterval = 180, specNotes: String = "Workout-specifc notes", tempo: String = "XXXX") {
        self.exercise = exercise
        self.sets = sets
        self.restTime = restTime
        self.specNotes = specNotes
        self.tempo = tempo
    }
}
