//
//  WorkoutLog.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/17/25.
//

import Foundation
import SwiftData

@Model
class WorkoutLog: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    
    var workout: Workout
    var started: Bool
    var completed: Bool
    var start: Double
    var end: Double
    var exerciseLogs: [ExerciseLog] = []
    
    init(workout: Workout) {
        self.workout = workout
        started = false
        completed = false
        start = Date().timeIntervalSince1970.rounded()
        end = 0
        
        for exercise in workout.exercises {
            exerciseLogs.append(ExerciseLog(exercise: exercise))
        }
    }
    
    func lengthToString() -> String {
        let length = end - start
        let hours = Int(length) / 3600
        let minutes = (Int(length) % 3600) / 60
        let seconds = Int(length) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func finishWorkout() {
        for exerciseLog in exerciseLogs {
            if !exerciseLog.completed {
                exerciseLog.completed = true
                for setLog in exerciseLog.setLogs {
                    if !setLog.completed && !setLog.skipped {
                        setLog.skip()
                    }
                }
            }
        }
    }
    
    func getTotalReps() -> Int {
        var reps: Int = 0
        
        for exerciseLog in exerciseLogs {
            for setLog in exerciseLog.setLogs {
                reps += setLog.reps
            }
        }
        
        return reps
    }
    
    func getTotalWeight() -> Double {
        var weight: Double = 0
        
        for exerciseLog in exerciseLogs {
            for setLog in exerciseLog.setLogs {
                weight += setLog.weight
            }
        }
        
        return weight
    }
}
