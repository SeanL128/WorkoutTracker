//
//  EditMovement.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI
import SwiftData

struct EditMovement: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    var exercise: Exercise

    init(exercise: Exercise) {
        self.exercise = exercise
        _name = State(initialValue: exercise.name) // Prefill with current name
    }

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Save Changes") {
                exercise.name = name
                try? context.save() // Save updates to the model
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Edit Movement")
        .padding()
    }
}

#Preview {
    EditMovement(exercise: Exercise())
}
