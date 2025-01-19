//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) var context
    
    @Query var workouts: [Workout]
    @Query var workoutLogs: [WorkoutLog]
    @Query var exercises: [Exercise]
    
    @State var deleteExercise: (Bool, Exercise) = (false, Exercise())
    @State var deleteWorkout: (Bool, Workout) = (false, Workout())
    
    @State private var showViewWorkout: Bool = false
    @State private var selectedWorkout: Workout?
    @State private var selectedLog: WorkoutLog?
    
    var body: some View {
        if showViewWorkout, let workout = selectedWorkout, let log = selectedLog {
            ViewWorkout(workout: workout, workoutLog: log, onBack: {
                showViewWorkout = false
            })
            .transition(.move(edge: .trailing))
        } else {
            TabView {
                WorkoutList { workout, log in
                    selectedWorkout = workout
                    selectedLog = log
                    showViewWorkout = true
                }
                .tabItem {
                    Label("Workouts", systemImage: "figure.run")
                }
                
                ExerciseList()
                    .tabItem {
                        Label("Exercises", systemImage: "dumbbell.fill")
                    }
                
                Stats()
                    .tabItem {
                        Label("Stats", systemImage: "chart.xyaxis.line")
                    }
            }
            .onAppear {
                ensureDailyWorkoutLogs(context: context, workouts: workouts)
            }
            .transition(.move(edge: .leading))
        }
    }
    
    func ensureDailyWorkoutLogs(context: ModelContext, workouts: [Workout]) {
        let today = Calendar.current.startOfDay(for: Date())
        let lastChecked = UserDefaults.standard.object(forKey: "lastCheckedDate") as? Date

        if lastChecked == nil || !Calendar.current.isDate(lastChecked!, inSameDayAs: today) {
            UserDefaults.standard.set(today, forKey: "lastCheckedDate")

            let workoutLogs: [WorkoutLog] = try! context.fetch(FetchDescriptor<WorkoutLog>())
            let existingLogs = workoutLogs.filter { log in
                Calendar.current.isDate(Date(timeIntervalSince1970: log.start), inSameDayAs: today)
            }

            if existingLogs.isEmpty {
                for workout in workouts {
                    let newLog = WorkoutLog(workout: workout)
                    context.insert(newLog)
                }

                try? context.save()
            }
        }
    }
}

#Preview {
    MainView()
}
