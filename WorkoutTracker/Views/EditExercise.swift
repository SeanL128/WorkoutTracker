//
//  EditMovement.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI
import SwiftData

struct EditExercise: View {
    // Environment Variables
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    // State Variables
    @State private var name: String = ""
    
    @State private var notes: String = ""
    
    @State private var restMinutes: Int = 0
    @State private var restSeconds: Int = 0
    
    // View Models
    @StateObject var muscleGroupViewModel = MuscleGroupSelectionViewModel()
    
    var exercise: Exercise

    init(exercise: Exercise) {
        self.exercise = exercise
        _name = State(initialValue: exercise.name)
        _notes = State(initialValue: exercise.notes)
        muscleGroupViewModel.selectedMuscleGroups = exercise.muscleGroups
        
        // Convert restTime TimeInterval to minutes and seconds
        let restTotalSeconds = Double(exercise.restTime)
        _restMinutes = State(initialValue: Int(restTotalSeconds / 60))
        _restSeconds = State(initialValue: Int(restTotalSeconds - Double(restMinutes * 60)))
        
    }

    var body: some View {
        NavigationView {
            VStack {
                // Name
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                // Notes
                TextField("Notes", text: $notes, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                
                Spacer()
                
                
                HStack(spacing: 20) {
                    Text("Rest Time")
                    
                    // Minutes Picker
                    Picker("Minutes", selection: $restMinutes) {
                        ForEach(Array(0...59), id: \.self) { minute in
                            Text("\(minute) min")
                                .tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: 100)
                    .clipped()
                    
                    // Seconds Picker
                    Picker("Seconds", selection: $restSeconds) {
                        ForEach([0, 15, 30, 45], id: \.self) { second in
                            Text("\(second) sec")
                                .tag(second)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: 100)
                    .clipped()
                }
                .padding()
                
                // Display Selected Muscle Groups
                if !muscleGroupViewModel.selectedMuscleGroups.isEmpty {
                    Text("Selected: \(muscleGroupViewModel.selectedMuscleGroups.map { $0.rawValue.capitalized }.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding()
                }
                
                // Select Muscle Groups
                Menu {
                    ForEach(MuscleGroup.displayOrder, id: \.self) { muscleGroup in
                        Button(action: {
                            muscleGroupViewModel.toggleSelection(muscleGroup)
                        }) {
                            HStack {
                                Text(muscleGroup.rawValue.capitalized)
                                if muscleGroupViewModel.isSelected(muscleGroup) {
                                    Spacer()
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    Text("Select Muscle Groups")
                }
                .padding(.bottom, 25)
                
                Button("Save Exercise") {
                    saveExercise()
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    name.trimmingCharacters(in: .whitespaces).isEmpty ||
                    !muscleGroupViewModel.canSave
                )

            }
            .padding()
            .navigationTitle(Text("Edit Exercise"))
        }
    }
    
    private func saveExercise() {
        let restTotalSeconds = (Double(restMinutes) * 60) + Double(restSeconds)
        let restTimeInterval = TimeInterval(restTotalSeconds)
        let newExercise = Exercise(name: name,
                                   notes: notes,
                                   restTime: restTimeInterval,
                                   muscleGroups: muscleGroupViewModel.selectedMuscleGroups)
        context.insert(newExercise)
        try? context.save()
        dismiss()
    }
}

#Preview {
    EditExercise(exercise: Exercise())
}
