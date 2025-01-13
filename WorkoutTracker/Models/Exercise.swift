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
    var equipment: [String]
    var notes: String
    var restTime: TimeInterval
    var muscleGroups: [MuscleGroup]
    
    init(name: String = "", equipment: [String] = [], notes: String = "", restTime: TimeInterval = 0, muscleGroups: [MuscleGroup] = []) {
        self.name = name
        self.equipment = equipment
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

enum MuscleGroup: String, CaseIterable, Codable {
    case chest
    case back
    case biceps
    case triceps
    case shoulders
    case quads
    case hamstrings
    case glutes
    case core
    case cardio
    case other
}
