//
//  SelectExercise.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/14/25.
//

import SwiftUI
import SwiftData

struct SelectExercise: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
        
    @Query var exercises: [Exercise]
    
    @Binding var selectedExercise: Exercise?
    @Binding var selectingExercise: Bool
    
    var groupedExercises: [MuscleGroup: [Exercise]] {
        Dictionary(grouping: exercises, by: { exercise in
            exercise.muscleGroup ?? MuscleGroup.other
        })
        .mapValues { exercises in
            exercises.sorted { $0.name.lowercased() < $1.name.lowercased() } // Sorting exercises alphabetically by name
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(MuscleGroup.allCases, id: \.self) { muscleGroup in
                    if let exercisesForGroup = groupedExercises[muscleGroup], !exercisesForGroup.isEmpty {
                        Section(header: Text(muscleGroup.rawValue.capitalized)) {
                            ForEach(exercisesForGroup) { exercise in
                                Button {
                                    selectedExercise = exercise
                                    selectingExercise = false
                                } label: {
                                    HStack {
                                        Text(exercise.name)
                                        Spacer()
                                        if selectedExercise == exercise {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                                .foregroundStyle(Color.white)
                            }
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .toolbar {
                NavigationLink(destination: AddExercise()) {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle(Text("Select Exercise"))
        }
    }
}
