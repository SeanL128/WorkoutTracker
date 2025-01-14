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
    var name: String
    var notes: String
    var restTime: TimeInterval
    var muscleGroups: [MuscleGroup]
    
    init(name: String = "", notes: String = "", restTime: TimeInterval = 0, muscleGroups: [MuscleGroup] = []) {
        self.name = name
        self.notes = notes
        self.restTime = restTime
        self.muscleGroups = Array(muscleGroups.prefix(3))
    }
    
    func addMuscleGroup(_ group: MuscleGroup) -> Bool {
        guard muscleGroups.count < 3 else {
            print("Cannot add more than 3 muscle groups.")
            return false
        }
        
        muscleGroups.append(group)
        return true
    }
    
    func removeMuscleGroup(_ group: MuscleGroup) {
        muscleGroups.removeAll { $0 == group }
    }
}

enum MuscleGroup: String, CaseIterable, Codable, Identifiable {
    case chest, back, biceps, triceps, shoulders, quads, hamstrings, glutes, core, cardio, other
    
    var id: String { self.rawValue }
    
    static let displayOrder: [MuscleGroup] = [
        .other, .cardio, .core, .glutes, .hamstrings, .quads,
        .shoulders, .triceps, .biceps, .back, .chest
    ]
}
