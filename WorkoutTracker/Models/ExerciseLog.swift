//
//  ExerciseLog.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/17/25.
//

import Foundation
import SwiftData

@Model
class ExerciseLog: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    
    var completed: Bool
    var start: Double
    var end: Double
    var setLogs: [SetLog] = []
    
    init(exercise: WorkoutExercise) {
        completed = false
        start = Date().timeIntervalSince1970.rounded()
        end = 0
        
        for _ in exercise.sets {
            setLogs.append(SetLog())
        }
    }
    
    
    func toggle() {
        completed.toggle()
        
        if completed { end = Date().timeIntervalSince1970.rounded() }
        else { end = 0 }
    }
    
    func finish() {
        completed = true
        end = Date().timeIntervalSince1970.rounded()
    }
    
    func unfinish() {
        completed = false
        end = 0
    }
}
