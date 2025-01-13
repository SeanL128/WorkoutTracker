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
    @Query var movements: [Movement]
    
    @State var delete: (Bool, Movement) = (false, Movement())
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(movements) { movement in
                        HStack {
                            Text(movement.name)
                            Spacer()
                            NavigationLink(destination: EditMovement(movement: movement)) {
                            }
                        }
                        .swipeActions {
                            Button("Delete") {
                                delete.0 = true
                                delete.1 = movement
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
                
                NavigationLink("Add Movement", destination: AddMovement())
            }
            .navigationTitle("Workout Tracker")
        }
    }
}

#Preview {
    MainView()
}
