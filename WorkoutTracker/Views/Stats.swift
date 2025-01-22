//
//  Stats.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/19/25.
//

import SwiftUI
import SwiftData
import Charts

struct Stats: View {
    @Query var workouts: [Workout]
    @Query var exercises: [Exercise]
    @Query var workoutLogs: [WorkoutLog]
    
    // View Model
    @StateObject private var viewModel: StatsViewModel = StatsViewModel()
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .center) {
                Text(viewModel.title)
                    .font(.title.bold())
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                Spacer()
                
                Menu("View \(Image(systemName: "chevron.up.chevron.down"))") {
                    Button {
                        viewModel.selectOverall()
                    } label: {
                        Text("Overall")
                    }
                    
                    Menu("Workout") {
                        ForEach(viewModel.data?.workouts ?? [], id: \.self) { workout in
                            Button {
                                viewModel.selectWorkout(workout: workout)
                            } label: {
                                Text(workout.name)
                            }
                        }
                    }
                    
                    Menu("Exercise") {
                        ForEach(viewModel.data?.exercises ?? [], id: \.self) { exercise in
                            Button {
                                viewModel.selectExercise(exercise: exercise)
                            } label: {
                                Text(exercise.name)
                            }
                        }
                    }
                }
            }
            .padding()
            
            ScrollView {
                viewModel.stats
            }
        }
        .onAppear() {
            viewModel.updateWorkoutLogs(workoutLogs: workoutLogs)
        }
    }
}

#Preview {
    Stats()
}
