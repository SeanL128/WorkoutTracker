//
//  ExerciseList.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/18/25.
//

import SwiftUI
import SwiftData

struct ExerciseList: View {
    @Environment(\.modelContext) var context
    
    @Query var exercises: [Exercise]
    
    @State var delete: (Bool, Exercise) = (false, Exercise())
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Exercises")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink(destination: AddExercise()) {
                        Image(systemName: "plus")
                    }
                }
                .padding()
                
                List {
                    ForEach(exercises) { exercise in
                        HStack {
                            Text(exercise.name)
                            Spacer()
                        }
                        .swipeActions {
                            Button("Delete") {
                                delete.0 = true
                                delete.1 = exercise
                            }
                            .tint(.red)
                        }
                    }
                }
                .confirmationDialog("Are you sure?", isPresented: $delete.0) {
                    Button("Delete \(delete.1.name)?", role: .destructive) {
                        context.delete(delete.1)
                        try? context.save()

                        delete.0 = false
                        delete.1 = Exercise()
                    }
                }
                
                NavigationLink("Add Exercise", destination: AddExercise())
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ExerciseList()
}
