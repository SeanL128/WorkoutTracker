//
//  Options.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/20/25.
//

import SwiftUI
import SwiftData

struct Options: View {
    @Query private var workouts: [Workout]
    @Query private var exercises: [Exercise]
    @Query private var workoutLogs: [WorkoutLog]
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Options")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            .padding()
            
            Button {
                // action
            } label: {
                Text("Export Information")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
    
    private func exportWorkouts() {
        do {
            let exportData = ExportData(workouts: workouts, exercises: exercises, workoutLogs: workoutLogs)
            
            // Step 1: Encode workouts to JSON
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(exportData)
            
            // Step 2: Write the data to a temporary file
            let temporaryURL = FileManager.default.temporaryDirectory.appendingPathComponent("WorkoutTrackerData.json")
            try data.write(to: temporaryURL)
            
            // Step 3: Share the file
            presentShareSheet(url: temporaryURL)
        } catch {
            print("Failed to export workouts: \(error.localizedDescription)")
        }
    }
    
    private func presentShareSheet(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}

#Preview {
    Options()
}
