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
    var id = UUID()
    
    var name: String
    var exercises: [Exercise]
    
    init(name: String = "", exercises: [Exercise] = []) {
        self.name = name
        self.exercises = exercises
    }
}
