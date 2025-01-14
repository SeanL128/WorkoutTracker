//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/12/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) var context
    
    @Query var workouts: [Workout]
    @Query var exercises: [Exercise]
    
    @State var delete: (Bool, Exercise) = (false, Exercise())
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(exercises) { exercise in
                        HStack {
                            Text(exercise.name)
                            Spacer()
                            NavigationLink(destination: EditExercise(exercise: exercise)) {
                            }
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
                    }
                }
                
                NavigationLink("Add Movement", destination: AddExercise())
            }
            .navigationTitle("Workout Tracker")
        }
    }
}

#Preview {
    MainView()
}
