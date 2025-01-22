//
//  ExportData.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/20/25.
//

import Foundation

struct ExportData: Codable {
    let workouts: [Workout]
    let exercises: [Exercise]
    let workoutLogs: [WorkoutLog]
}
