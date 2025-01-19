//
//  EditWorkout.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI
import SwiftData

struct EditWorkout: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: WorkoutViewModel
    
    @State private var titleAlert: Bool = false
    @State private var exercisesAlert: Bool = false
    
    init(workout: Workout) {
        _viewModel = StateObject(wrappedValue: WorkoutViewModel(workout: workout))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Workout Name", text: $viewModel.workoutName)
                    .textFieldStyle(.roundedBorder)
                
                List {
                    ForEach(viewModel.exercises.indices, id: \.self) { index in
                        let exercise = viewModel.exercises[index]
                        HStack {
                            Text(viewModel.exercises[index].exercise?.name ?? "Select Exercise")
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
                }
                
                
                TextField("Notes", text: $viewModel.notes, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                
                Button {
                    viewModel.addExercise()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Exercise")
                    }
                }
                
                Button {
                    guard !viewModel.workoutName.isEmpty else {
                        titleAlert = true
                        return
                    }
                    
                    guard viewModel.exercises.count > 0 else {
                        exercisesAlert = true
                        return
                    }
                    
                    viewModel.workout.name = viewModel.workoutName
                    viewModel.workout.exercises = viewModel.exercises
                    
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
            .navigationTitle("Edit Workout")
        }
    }
}

#Preview {
    EditWorkout(workout: Workout())
}

/*
 clicking an exercise brings up it's info, a rest time picker, and a button to save it in that slot
    this page can also be accessed through a tab on the main screen for easy exercise creation
 */
