//
//  AddWorkout.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI
import SwiftData

struct AddWorkout: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: WorkoutViewModel = WorkoutViewModel(workout: Workout(name: "", notes: ""))
    
    @State private var titleAlert: Bool = false
    @State private var exercisesAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Workout Name", text: $viewModel.workoutName)
                    .textFieldStyle(.roundedBorder)
                
                List {
                    ForEach(viewModel.exercises.indices, id: \.self) { index in
                        let exercise = viewModel.exercises[index]
                        HStack {
                            Text(exercise.exercise?.name ?? "Select Exercise")
                            NavigationLink(destination: ExerciseInfo(workout: viewModel.workout, exercise: exercise.exercise ?? nil, workoutExercise: $viewModel.exercises[index])) {
                            }
                        }
                        .swipeActions {
                            Button("Delete") {
                                viewModel.removeExercise(at: index)
                            }
                            .tint(.red)
                        }
                    }
                    .onMove { from, to in
                        viewModel.exercises.move(fromOffsets: from, toOffset: to)
                    }
                }
                .backgroundStyle(.clear)
                
                Button {
                    viewModel.addExercise()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Exercise")
                    }
                }
                
                
                TextField("Notes", text: $viewModel.notes, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                
                Button {
                    guard !viewModel.workoutName.isEmpty else {
                        titleAlert = true
                        return
                    }
                    
//                    guard viewModel.exercises.count > 0 else {
//                        exercisesAlert = true
//                        return
//                    }
                    
                    var blankCount = 0
                    for exercise in viewModel.exercises {
                        if exercise.exercise == nil {
                            viewModel.exercises.remove(at: viewModel.exercises.firstIndex(of: exercise)!)
                            blankCount += 1
                        }
                    }
                    
                    guard viewModel.exercises.count > 0 else {
                        for _ in 0..<blankCount {
                            viewModel.addExercise()
                        }
                        
                        exercisesAlert = true
                        return
                    }
                    
                    viewModel.workout.name = viewModel.workoutName
                    viewModel.workout.exercises = viewModel.exercises
                    
                    context.insert(viewModel.workout)
                    context.insert(WorkoutLog(workout: viewModel.workout))
                    try? context.save()
                    
                    dismiss()
                } label: {
                    HStack {
                        Text("Save")
                    }
                }
                .padding(.top)
                .buttonStyle(.borderedProminent)
                .alert(isPresented: $titleAlert) {
                    Alert(title: Text("Error"),
                          message: Text("Please name this workout."))
                }
                .alert(isPresented: $exercisesAlert) {
                    Alert(title: Text("Error"),
                          message: Text("Please add at least one exercise."))
                }
            }
            .padding()
            .navigationTitle("Add Workout")
        }
    }
}

#Preview {
    AddWorkout()
}

/*
 clicking an exercise brings up it's info, a rest time picker, and a button to save it in that slot
    this page can also be accessed through a tab on the main screen for easy exercise creation
 */
