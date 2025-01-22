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
    
    // View Model
    @StateObject private var viewModel: StatsViewModel
    
    init() {
        workout = Workout(name: "Upper Body Strength")
        workout.addWorkout(exercise: Exercise(name: "Bench Press", muscleGroup: .chest), sets: [ExerciseSet(reps: 8, weight: 135), ExerciseSet(reps: 8, weight: 140), ExerciseSet(reps: 6, weight: 145)], restTime: 60)
        workout.addWorkout(exercise: Exercise(name: "Bicep Curl", muscleGroup: .biceps), sets: [ExerciseSet(reps: 12, weight: 25), ExerciseSet(reps: 12, weight: 30), ExerciseSet(reps: 10, weight: 35)], restTime: 60)

        workoutLog1 = WorkoutLog(workout: workout)
        workoutLog1.started = true
        workoutLog1.completed = true
        workoutLog1.start = 1735563122
        workoutLog1.end = 1735743122
        
        workoutLog1.exerciseLogs[0].setLogs[0].finish(weight: 135, reps: 8)
        workoutLog1.exerciseLogs[0].setLogs[1].finish(weight: 140, reps: 8)
        workoutLog1.exerciseLogs[0].setLogs[2].finish(weight: 145, reps: 6)
        workoutLog1.exerciseLogs[1].setLogs[0].finish(weight: 25, reps: 12)
        workoutLog1.exerciseLogs[1].setLogs[1].finish(weight: 30, reps: 12)
        workoutLog1.exerciseLogs[1].setLogs[2].finish(weight: 35, reps: 10)
        

        workoutLog2 = WorkoutLog(workout: workout)
        workoutLog2.started = true
        workoutLog2.completed = true
        workoutLog2.start = 1737121322
        workoutLog2.end = 1737124334
        
        workoutLog2.exerciseLogs[0].setLogs[0].finish(weight: 135, reps: 10)
        workoutLog2.exerciseLogs[0].setLogs[1].finish(weight: 140, reps: 10)
        workoutLog2.exerciseLogs[0].setLogs[2].finish(weight: 145, reps: 8)
        workoutLog2.exerciseLogs[1].setLogs[0].finish(weight: 40, reps: 14)
        workoutLog2.exerciseLogs[1].setLogs[1].finish(weight: 45, reps: 14)
        workoutLog2.exerciseLogs[1].setLogs[2].finish(weight: 50, reps: 12)
        

        workoutLog3 = WorkoutLog(workout: workout)
        workoutLog3.started = true
        workoutLog3.completed = true
        workoutLog3.start = 1737472802
        workoutLog3.end = 1737473902
        
        workoutLog3.exerciseLogs[0].setLogs[0].finish(weight: 145, reps: 10)
        workoutLog3.exerciseLogs[0].setLogs[1].finish(weight: 150, reps: 10)
        workoutLog3.exerciseLogs[0].setLogs[2].finish(weight: 155, reps: 8)
        workoutLog3.exerciseLogs[1].setLogs[0].finish(weight: 60, reps: 12)
        workoutLog3.exerciseLogs[1].setLogs[1].finish(weight: 65, reps: 12)
        workoutLog3.exerciseLogs[1].setLogs[2].finish(weight: 70, reps: 10)
        
        let logs = [workoutLog1, workoutLog2, workoutLog3]
        _viewModel = StateObject(wrappedValue: StatsViewModel(workoutLogs: logs))
    }
    
    var body: some View {
        /*
         overall, exercise, workout
             total weight
             total reps
         
         exercise
            graph showing reps and weight over time
         */
        NavigationStack {
            HStack(alignment: .center) {
                Text(viewModel.title)
                    .font(.title.bold())
                    .truncationMode(.tail)
                
                Spacer()
                
                Menu("View \(Image(systemName: "chevron.up.chevron.down"))") {
                    Button {
                        viewModel.selectOverall()
                    } label: {
                        Text("Overall")
                    }
                    
                    Menu("Workout") {
                        ForEach(viewModel.data.workouts, id: \.self) { workout in
                            Button {
                                viewModel.selectWorkout(workout: workout)
                            } label: {
                                Text(workout.name)
                            }
                        }
                    }
                    
                    Menu("Exercise") {
                        ForEach(viewModel.data.exercises, id: \.self) { exercise in
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
                VStack {
                    if viewModel.showCharts {
                        getMuscleGroupBreakdownChart(for: viewModel.selectedMuscleGroupRepBreakdown)
                    }
                    
                    if viewModel.showGraph {
                        if viewModel.showCharts {
                            Divider()
                                .padding()
                        }
                        
                        getGraph()
                    }
                    
                    Spacer()
                }
                .navigationBarHidden(true)
                .padding()
            }
        }
    }
    
    private func getMuscleGroupBreakdownChart(for dict: [MuscleGroup: Int]) -> some View {
        // Mode text to correct spots
        VStack {
            let keys = Array(dict.keys)
            
            Chart {
                ForEach(MuscleGroup.displayOrder.reversed(), id: \.self) { key in
                    if key != .overall && keys.contains(key) {
                        SectorMark(
                            angle: .value(key.rawValue.capitalized, dict[key] ?? 0),
                            innerRadius: .ratio(0.8),
                            angularInset: 2
                        )
                        .cornerRadius(3)
                        .foregroundStyle(MuscleGroup.colorMap[key]!)
                    }
                }
            }
            .scaledToFit()
            .chartForegroundStyleScale(MuscleGroup.colorKeyValuePairs)
            .chartLegend(.visible)
            .chartLegend(alignment: .center, spacing: 16)
            .chartBackground { chartProxy in
                GeometryReader { geometry in
                    if let anchor = chartProxy.plotFrame {
                        let frame = geometry[anchor]
                        Text("\(viewModel.selectedMuscleGroupRepBreakdown[.overall] ?? 0) reps")
                            .font(.callout)
                            .position(x: frame.midX, y: frame.midY)
                    }
                }
            }
            
            VStack {
                ForEach(MuscleGroup.displayOrder.reversed(), id: \.self) { key in
                    if key != .overall && keys.contains(key) {
                        Text("\(key.rawValue.capitalized): \(dict[key] ?? 0) reps")
                    }
                }
            }
            .padding(.top)
            
            Divider()
                .padding()
            
            Chart {
                ForEach(MuscleGroup.displayOrder.reversed(), id: \.self) { key in
                    if key != .overall && keys.contains(key) {
                        SectorMark(
                            angle: .value(key.rawValue.capitalized, dict[key] ?? 0),
                            innerRadius: .ratio(0.8),
                            angularInset: 2
                        )
                        .cornerRadius(3)
                        .foregroundStyle(MuscleGroup.colorMap[key]!)
                    }
                }
            }
            .scaledToFit()
            .chartForegroundStyleScale(MuscleGroup.colorKeyValuePairs)
            .chartLegend(.visible)
            .chartLegend(alignment: .center, spacing: 16)
            .chartBackground { chartProxy in
                GeometryReader { geometry in
                    if let anchor = chartProxy.plotFrame {
                        let frame = geometry[anchor]
                        Text("\(viewModel.selectedMuscleGroupWeightBreakdown[.overall]?.formatted() ?? 0.formatted())lbs")
                            .font(.callout)
                            .position(x: frame.midX, y: frame.midY)
                    }
                }
            }
            
            VStack {
                ForEach(MuscleGroup.displayOrder.reversed(), id: \.self) { key in
                    if key != .overall && keys.contains(key) {
                        Text("\(key.rawValue.capitalized): \(dict[key]?.formatted() ?? 0.formatted())lbs")
                    }
                }
            }
            .padding(.top)
        }
    }
    
    private func getGraph() -> some View {
        VStack {
            Picker("Graph View", selection: $viewModel.selectedGraphView) {
                ForEach(["1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"], id: \.self) { value in
                    Text(value)
                        .tag(value)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            let info = viewModel.getGraphInfo()
            
            Chart {
                ForEach(info, id: \.0) { log in
                    LineMark (
                        x: .value("Date", Date(timeIntervalSince1970: log.2)),
                        y: .value("Reps", log.0)
                    )
                    .foregroundStyle(by: .value("Value", "Reps"))
                    
                    PointMark (
                        x: .value("Date", Date(timeIntervalSince1970: log.2)),
                        y: .value("Reps", log.0)
                    )
                    .foregroundStyle(by: .value("Value", "Reps"))
                    
                    
                    LineMark (
                        x: .value("Date", Date(timeIntervalSince1970: log.2)),
                        y: .value("Weight", log.1)
                    )
                    .foregroundStyle(by: .value("Value", "Weight"))
                    
                    PointMark (
                        x: .value("Date", Date(timeIntervalSince1970: log.2)),
                        y: .value("Weight", log.1)
                    )
                    .foregroundStyle(by: .value("Value", "Weight"))
                }
                .interpolationMethod(.catmullRom)
            }
            .chartForegroundStyleScale([
                "Reps": Color(UIColor { traitCollection in
                    traitCollection.userInterfaceStyle == .dark ? .white : .black
                }),
                "Weight": .accentColor
            ])
            .chartXAxis {
                AxisMarks(position: .bottom) {
                    AxisValueLabel()
                    AxisTick()
                    AxisGridLine()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { }
            }
            .chartXScale(domain: viewModel.getXScale())
            .chartYScale(domain: -0.05...1.05)
            .chartLegend(position: .bottom)
            .chartPlotStyle { plotArea in
                plotArea
                    .background(Color.gray.opacity(0.1))
                    .border(Color.gray, width: 1)
            }
            .clipped()
            .frame(height: 400)
        }
    }
}

#Preview {
    Stats()
}
