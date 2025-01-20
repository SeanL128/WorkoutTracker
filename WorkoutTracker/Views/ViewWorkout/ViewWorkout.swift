//
//  ViewWorkout.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/16/25.
//

import SwiftUI

struct ViewWorkout: View {
    @Environment(\.modelContext) private var context
    
    @StateObject private var viewModel: WorkoutViewModel
    
    @State private var restTime: Double = 0
    
    @State private var finishWorkout: Bool = false
    
    var log: WorkoutLog
    var onBack: () -> Void
    
    init(workout: Workout, workoutLog: WorkoutLog, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: WorkoutViewModel(workout: workout))
        log = workoutLog
        self.onBack = onBack
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                onBack()
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        
                        Spacer()
                    }
                    .frame(width: 55)
                    
                    Spacer()
                    
                    Text(viewModel.workoutName)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    HStack {
                        NavigationLink(destination: EditWorkout(workout: viewModel.workout)) {
                            Image(systemName: "pencil")
                        }
                        
                        Spacer()
                        
                        Button {
                            finishWorkout = true
                        } label: {
                            Image(systemName: "checkmark")
                        }
                    }
                    .frame(width: 55)
                    .confirmationDialog("Are you sure? This will skip all remaining sets", isPresented: $finishWorkout) {
                        Button("Finish \(viewModel.workoutName)?", role: .destructive) {
                            log.finishWorkout()
                            try? context.save()
                            
                            finishWorkout = false
                        }
                    }
                }
                .padding()
                
                TabView {
                    ForEach(viewModel.exercises.indices, id: \.self) { index in
                        PerformExercise(workout: viewModel.workout, log: log, index: index, time: $restTime)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                Text("Rest Time: \(timeIntervalToString(time: getRemainingTime()))")
            }
            .navigationBarHidden(true)
            .onChange(of: restTime) {
                startRestTime(duration: restTime)
            }
        }
    }
    
    private func startRestTime(duration: Double) {
        let endTime = Date().addingTimeInterval(duration)
        UserDefaults.standard.set(endTime, forKey: "restEndTime")
    }
    
    private func getRemainingTime() -> Double {
        guard let endTime = UserDefaults.standard.object(forKey: "restEndTime") as? Date else {
            return 0
        }
        
        return max(0, endTime.timeIntervalSinceNow)
    }
    
    private func timeIntervalToString(time: Double) -> String {
        let interval = Int(time)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    @Previewable @State var showViewWorkout: Bool = false
    
    ViewWorkout(workout: Workout(), workoutLog: WorkoutLog(workout: Workout()), onBack: {
        showViewWorkout = false;
    })
}
