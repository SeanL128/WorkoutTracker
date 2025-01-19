//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI
import SwiftData

@main
struct WorkoutTrackerApp: App {
    @Environment(\.modelContext) private var context
    @Query private var workouts: [Workout]
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [Workout.self, Exercise.self, WorkoutLog.self])
        }
    }
}
