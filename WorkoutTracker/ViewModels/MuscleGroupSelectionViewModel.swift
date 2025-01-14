//
//  MuscleGroupSelectionViewModel.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/13/25.
//

import Foundation

class MuscleGroupSelectionViewModel: ObservableObject {
    @Published var selectedMuscleGroups: [MuscleGroup] = []
    
    func toggleSelection(_ muscleGroup: MuscleGroup) {
        if selectedMuscleGroups.contains(muscleGroup) {
            selectedMuscleGroups.removeAll { $0 == muscleGroup }
        } else if selectedMuscleGroups.count < 3 {
            selectedMuscleGroups.append(muscleGroup)
        }
    }

    func isSelected(_ muscleGroup: MuscleGroup) -> Bool {
        selectedMuscleGroups.contains(muscleGroup)
    }
    
    var canSave: Bool {
        selectedMuscleGroups.count >= 0 && selectedMuscleGroups.count <= 3
    }
}
