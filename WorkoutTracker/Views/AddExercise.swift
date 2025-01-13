//
//  AddMovement.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI

struct AddExercise: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                Button("Save Movement") {
                    let newExercise = Exercise(name: name)
                    context.insert(newExercise)
                    try? context.save()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)

            }
            .padding()
        }
        .navigationTitle("Add Exercise")
    }
}

#Preview {
    AddExercise()
}
