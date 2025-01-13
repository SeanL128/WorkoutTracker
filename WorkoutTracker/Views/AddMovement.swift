//
//  AddMovement.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI

struct AddMovement: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            Button("Save Movement") {
                let newMovement = Movement(name: name)
                context.insert(newMovement)
                try? context.save()
                dismiss()
            }
            .buttonStyle(.borderedProminent)

        }
        .padding()
    }
}

#Preview {
    AddMovement()
}
