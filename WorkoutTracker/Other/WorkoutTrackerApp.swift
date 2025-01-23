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
    
    init() {
        let container = try! ModelContainer(for: Workout.self, Exercise.self, WorkoutLog.self)
        preloadData(context: container.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [Workout.self, Exercise.self, WorkoutLog.self])
        }
    }
    
    private func preloadData(context: ModelContext) {
        let fetchRequest = FetchDescriptor<Exercise>()
        if let existingExercises = try? context.fetch(fetchRequest), existingExercises.isEmpty {
            let defaultExercises = [
                Exercise(name: "Push-Up", muscleGroup: .chest),
                Exercise(name: "Barbell Bench Press", muscleGroup: .chest),
                Exercise(name: "Incline Barbell Bench Press", muscleGroup: .chest),
                Exercise(name: "Decline Barbell Bench Press", muscleGroup: .chest),
                Exercise(name: "Dumbbell Bench Press", muscleGroup: .chest),
                Exercise(name: "Incline Dumbbell Bench Press", muscleGroup: .chest),
                Exercise(name: "Decline Dumbbell Bench Press", muscleGroup: .chest),
                Exercise(name: "Smith Machine Bench Press", muscleGroup: .chest),
                Exercise(name: "Incline Smith Machine Bench Press", muscleGroup: .chest),
                Exercise(name: "Decline Smith Machine Bench Press", muscleGroup: .chest),
                Exercise(name: "Pull-Up", muscleGroup: .back),
                Exercise(name: "Machine-Assisted Pull-Up", muscleGroup: .back),
                Exercise(name: "Band-Assisted Pull-Up", muscleGroup: .back),
                Exercise(name: "Deadlift", muscleGroup: .back),
                Exercise(name: "Dumbbell Deadlift", muscleGroup: .back),
                Exercise(name: "Smith Machine Deadlift", muscleGroup: .back),
                Exercise(name: "Dumbbell Bicep Curl", muscleGroup: .biceps),
                Exercise(name: "Dumbbell Hammer Curl", muscleGroup: .biceps),
                Exercise(name: "Cable Bicep Curl", muscleGroup: .biceps),
                Exercise(name: "Cable Hammer Curl", muscleGroup: .biceps),
                Exercise(name: "Alternating Dumbbell Bicep Curl", muscleGroup: .biceps),
                Exercise(name: "Alternating Dumbbell Hammer Curl", muscleGroup: .biceps),
                Exercise(name: "EZ-Bar Bicep Curl", muscleGroup: .biceps),
                Exercise(name: "Barbell Bicep Curl", muscleGroup: .biceps),
                Exercise(name: "Machine Preacher Curl", muscleGroup: .biceps),
                Exercise(name: "EZ-Bar Preacher Curl", muscleGroup: .biceps),
                Exercise(name: "Dumbbell Preacher Curl", muscleGroup: .biceps),
                Exercise(name: "Barbell Preacher Curl", muscleGroup: .biceps),
                Exercise(name: "Tricep Dip", muscleGroup: .triceps),
                Exercise(name: "Machine Tricep Dip", muscleGroup: .triceps),
                Exercise(name: "Dumbbell Shoulder Press", muscleGroup: .shoulders),
                Exercise(name: "Barbell Shoulder Press", muscleGroup: .shoulders),
                Exercise(name: "Smith Machine Shoulder Press", muscleGroup: .shoulders),
                Exercise(name: "Machine Shoulder Press", muscleGroup: .shoulders),
                Exercise(name: "Dumbbell Squat", muscleGroup: .quads),
                Exercise(name: "Smith Machine Squat", muscleGroup: .quads),
                Exercise(name: "Barbell Squat", muscleGroup: .quads),
                Exercise(name: "Dumbbell Lunge", muscleGroup: .quads),
                Exercise(name: "Barbell Lunge", muscleGroup: .quads),
                Exercise(name: "Smith Machine Lunge", muscleGroup: .quads),
                Exercise(name: "Dumbbell Romanian Deadlift", muscleGroup: .hamstrings),
                Exercise(name: "Barbell Romanian Deadlift", muscleGroup: .hamstrings),
                Exercise(name: "Smith Machine Romanian Deadlift", muscleGroup: .hamstrings),
                Exercise(name: "Barbell Hip Thrust", muscleGroup: .glutes),
                Exercise(name: "Smith Machine Hip Thrust", muscleGroup: .glutes),
                Exercise(name: "Plank", muscleGroup: .core),
                Exercise(name: "Leg Extension", muscleGroup: .quads),
                Exercise(name: "Leg Curl", muscleGroup: .hamstrings),
                Exercise(name: "One-Leg Leg Extension", muscleGroup: .quads),
                Exercise(name: "One-Leg Leg Curl", muscleGroup: .hamstrings),
                Exercise(name: "Leg Press", muscleGroup: .quads),
                Exercise(name: "Dumbbell Chest Fly", muscleGroup: .chest),
                Exercise(name: "Pec Deck", muscleGroup: .chest),
                Exercise(name: "Cable Rear Delt Fly", muscleGroup: .shoulders),
                Exercise(name: "Dumbbell Rear Delt Fly", muscleGroup: .shoulders),
                Exercise(name: "Machine Rear Delt Fly", muscleGroup: .shoulders),
                Exercise(name: "One-Arm Cable Rear Delt Fly", muscleGroup: .shoulders),
                Exercise(name: "One-Arm Dumbbell Rear Delt Fly", muscleGroup: .shoulders),
                Exercise(name: "One-Arm Machine Rear Delt Fly", muscleGroup: .shoulders),
                Exercise(name: "Lat Pulldown", muscleGroup: .back),
                Exercise(name: "Close-Grip Lat Pulldown", muscleGroup: .back),
                Exercise(name: "Wide-Grip Lat Pulldown", muscleGroup: .back),
                Exercise(name: "Machine Lat Pulldown", muscleGroup: .back),
                Exercise(name: "Cable Row", muscleGroup: .back),
                Exercise(name: "Close-Grip Cable Row", muscleGroup: .back),
                Exercise(name: "Wide-Grip Cable Row", muscleGroup: .back),
                Exercise(name: "Machine Row", muscleGroup: .back),
                Exercise(name: "Dumbbell Lateral Raise", muscleGroup: .shoulders),
                Exercise(name: "One-Arm Cable Lateral Raise", muscleGroup: .shoulders),
                Exercise(name: "Rope Triceps Pushdown", muscleGroup: .triceps),
                Exercise(name: "One-Arm Rope Triceps Pushdown", muscleGroup: .triceps),
                Exercise(name: "Straigth Bar Triceps Pushdown", muscleGroup: .triceps),
                Exercise(name: "One-Arm Straight Bar Triceps Pushdown", muscleGroup: .triceps),
                Exercise(name: "Rope Overhead Triceps Extension", muscleGroup: .triceps),
                Exercise(name: "One-Arm Rope Overhead Triceps Extension", muscleGroup: .triceps),
                Exercise(name: "Straigth Bar Overhead Triceps Extension", muscleGroup: .triceps),
                Exercise(name: "One-Arm Straight Bar Overhead Triceps Extension", muscleGroup: .triceps),
                Exercise(name: "Dumbbell Calf Raise", muscleGroup: .calves),
                Exercise(name: "Barbell Calf Raise", muscleGroup: .calves),
                Exercise(name: "Smith Machine Calf Raise", muscleGroup: .calves),
                Exercise(name: "Machine Calf Raise", muscleGroup: .calves),
                Exercise(name: "Dumbbell Bulgarian Split Squat", muscleGroup: .quads),
                Exercise(name: "Barbell Bulgarian Split Squat", muscleGroup: .quads),
                Exercise(name: "Smith Machine Bulgarian Split Squat", muscleGroup: .quads)
            ]
            
            for exercise in defaultExercises {
                context.insert(exercise)
            }
            
            do {
                try context.save()
            } catch {
                print("Error preloading data: \(error)")
            }
        }
    }
}
