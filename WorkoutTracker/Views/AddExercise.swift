//
//  AddExercise.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI
import SwiftData

struct AddExercise: View {
    @Environment(\.modelContext) private var context
    @State private var movement: Movement = Movement()
    @State private var sets : [ExerciseSet] = []
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AddExercise()
}
