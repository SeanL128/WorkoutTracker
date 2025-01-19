//
//  Stats.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/19/25.
//

import SwiftUI

struct Stats: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Stats")
                        .font(.largeTitle.bold())
                    
                    Spacer()
                    
                    NavigationLink(destination: AddWorkout()) {
                        Image(systemName: "plus")
                    }
                }
                .padding()
                
                Spacer()
                
                Text("TBD")
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    Stats()
}
