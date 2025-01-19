//
//  MuscleGroup.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/17/25.
//

import Foundation

enum MuscleGroup: String, CaseIterable, Codable, Identifiable {
    case chest, back, biceps, triceps, shoulders, quads, hamstrings, glutes, core, cardio, other
    
    var id: String { self.rawValue }
    
    static let displayOrder: [MuscleGroup] = [
        .other, .cardio, .core, .glutes, .hamstrings, .quads,
        .shoulders, .triceps, .biceps, .back, .chest
    ]
}
