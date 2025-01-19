//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import Foundation
import SwiftData

@Model
class Exercise: Identifiable {
    @Attribute(.unique) var id = UUID()
    
    var name: String
    var notes: String
    var muscleGroup: MuscleGroup?
    
    init(name: String = "Name", notes: String = "Notes", muscleGroup: MuscleGroup = MuscleGroup.other) {
        self.name = name
        self.notes = notes
        self.muscleGroup = muscleGroup
    }
}
