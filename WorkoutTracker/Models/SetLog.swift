//
//  SetLog.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/17/25.
//

import Foundation
import SwiftData

@Model
class SetLog: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    
    var completed: Bool
    var skipped: Bool
    var start: Double
    var end: Double
    
    var weight: Double
    
    init() {
        completed = false
        skipped = false
        start = Date().timeIntervalSince1970.rounded()
        end = 0
        weight = 0
    }
    
    func finish(weight: Double = 0) {
        completed = true
        end = Date().timeIntervalSince1970.rounded()
        self.weight = weight
    }
    
    func unfinish() {
        completed = false
        end = 0
        weight = 0
    }
    
    func skip() {
        skipped = true
        end = Date().timeIntervalSince1970.rounded()
        weight = 0
    }
    
    func unskip() {
        skipped = false
        end = 0
        weight = 0
    }
}
