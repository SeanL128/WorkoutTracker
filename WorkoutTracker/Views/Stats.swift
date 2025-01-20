//
//  Stats.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/19/25.
//

import SwiftUI
import Charts

struct Stats: View {
    private var workout: Workout
    private var workoutLog1: WorkoutLog
    private var workoutLog2: WorkoutLog
    private var workoutLog3: WorkoutLog
    
    private var data: [ChartData] = []
    private var maxWeight: Double
    private var maxReps: Int
    
    init() {
        workout = Workout(name: "Upper Body Strength")
        workout.addWorkout(exercise: Exercise(name: "Bench Press"), sets: [ExerciseSet(reps: 8, weight: 135), ExerciseSet(reps: 8, weight: 140), ExerciseSet(reps: 6, weight: 145)], restTime: 60)
        workout.addWorkout(exercise: Exercise(name: "Bicep Curl"), sets: [ExerciseSet(reps: 12, weight: 25), ExerciseSet(reps: 12, weight: 30), ExerciseSet(reps: 10, weight: 35)], restTime: 60)

        workoutLog1 = WorkoutLog(workout: workout)
        workoutLog1.started = true
        workoutLog1.completed = true
        workoutLog1.start = 1623425623
        workoutLog1.end = 1623426923
        
        workoutLog1.exerciseLogs[0].setLogs[0].finish(weight: 134, reps: 8)
        workoutLog1.exerciseLogs[0].setLogs[1].finish(weight: 140, reps: 8)
        workoutLog1.exerciseLogs[0].setLogs[2].finish(weight: 145, reps: 6)
        workoutLog1.exerciseLogs[1].setLogs[0].finish(weight: 25, reps: 12)
        workoutLog1.exerciseLogs[1].setLogs[1].finish(weight: 30, reps: 12)
        workoutLog1.exerciseLogs[1].setLogs[2].finish(weight: 35, reps: 10)
        

        workoutLog2 = WorkoutLog(workout: workout)
        workoutLog2.started = true
        workoutLog2.completed = true
        workoutLog2.start = 1623427023
        workoutLog2.end = 1623428323
        
        workoutLog2.exerciseLogs[0].setLogs[0].finish(weight: 135, reps: 10)
        workoutLog2.exerciseLogs[0].setLogs[1].finish(weight: 140, reps: 10)
        workoutLog2.exerciseLogs[0].setLogs[1].finish(weight: 145, reps: 8)
        workoutLog2.exerciseLogs[1].setLogs[0].finish(weight: 40, reps: 14)
        workoutLog2.exerciseLogs[1].setLogs[1].finish(weight: 45, reps: 14)
        workoutLog2.exerciseLogs[1].setLogs[1].finish(weight: 50, reps: 12)
        

        workoutLog3 = WorkoutLog(workout: workout)
        workoutLog3.started = true
        workoutLog3.completed = true
        workoutLog3.start = 1623428423
        workoutLog3.end = 1623429723
        
        workoutLog3.exerciseLogs[0].setLogs[0].finish(weight: 145, reps: 10)
        workoutLog3.exerciseLogs[0].setLogs[1].finish(weight: 150, reps: 10)
        workoutLog3.exerciseLogs[0].setLogs[1].finish(weight: 155, reps: 8)
        workoutLog3.exerciseLogs[1].setLogs[0].finish(weight: 60, reps: 12)
        workoutLog3.exerciseLogs[1].setLogs[1].finish(weight: 65, reps: 12)
        workoutLog3.exerciseLogs[1].setLogs[1].finish(weight: 70, reps: 10)
        
        let logs = [workoutLog1, workoutLog2, workoutLog3]
        
        for log in logs {
            data.append(ChartData(reps: log.getTotalReps(), weight: log.getTotalWeight(), date: Date(timeIntervalSince1970: log.start)))
        }
        
        maxWeight = data.compactMap { $0.weight }.max()!
        maxReps = data.compactMap { $0.reps }.max()!
    }
    
    
    var body: some View {
        /*
         overall
             total time working out
         
         overall, by exercise, by workout
             total weight
             total reps
             pie chart breaking down muscle group work
         
         exercise
            graph showing reps and weight over time
         */
        NavigationStack {
            VStack {
                HStack {
                    Text("Stats")
                        .font(.largeTitle.bold())
                    
                    Spacer()
                    
                    NavigationLink(destination: AddWorkout()) {
                        Image(systemName: "plus")
                    }
                }
                .padding()
                
                
                Spacer()
            }
            .navigationBarHidden(true)
            .padding()
        }
    }
    
    struct ChartData: Identifiable {
        var id: UUID = UUID()
        var reps: Int
        var weight: Double
        var date: Date
    }
}

#Preview {
    Stats()
}
