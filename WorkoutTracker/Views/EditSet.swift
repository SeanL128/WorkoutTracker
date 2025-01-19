//
//  EditSet.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/16/25.
//

import SwiftUI

struct EditSet: View {
    @Binding var set: ExerciseSet
    @Binding var exerciseStatus: Int
    @Binding var isPresented: Bool
    
    @State private var weight: Int = 40
    @State private var weightDecimal: Int = 0
    
    init (set: Binding<ExerciseSet>, exerciseStatus: Binding<Int> = .constant(0), isPresented: Binding<Bool> = .constant(false)) {
        self._set = set
        self._exerciseStatus = exerciseStatus
        self._isPresented = isPresented
        
        finishInit()
    }
    
    private func finishInit() {
        weight = Int(set.weight)
        weightDecimal = Int(set.weight.truncatingRemainder(dividingBy: 1) * 10)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    // Reps
                    Picker("Reps", selection: $set.reps) {
                        ForEach(Array(0...100), id: \.self) { rep in
                            Text("\(rep)")
                                .tag(rep)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: 100)
                    .clipped()
                    
                    Spacer()
                    
                    // Measurement
                    Picker("Measurement", selection: $set.measurement) {
                        ForEach(["x", "min", "sec"], id: \.self) { measurement in
                            Text("\(measurement)")
                                .tag(measurement)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: 75)
                    .clipped()
                    
                    Spacer()
                     
                    // Weight
                    HStack (spacing: 0) {
                        // Weight
                        Picker("Weight", selection: $weight) {
                            ForEach(Array(0...5000), id: \.self) { lb in
                                Text("\(lb)")
                                    .tag(lb)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: 100)
                        .clipped()
                        .padding(-7)
                        .onChange(of: weight) {
                            set.weight = Double(weight) + (Double(weightDecimal) / 100)
                        }
                        
                        Text(".")
                        
                        // Weight Decimals
                        Picker("Weight Decimals", selection: $weightDecimal) {
                            ForEach([0, 25, 50, 75], id: \.self) { dec in
                                Text("\(dec)")
                                    .tag(dec)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: 65)
                        .clipped()
                        .padding(-7)
                        .onChange(of: weightDecimal) {
                            set.weight = Double(weight) + (Double(weightDecimal) / 100)
                        }
                    }
                    
                    Text("lbs")
                }
                
                Picker("Type", selection: $set.type) {
                    ForEach(["Warm Up", "Main", "Drop Set", "Cool Down"], id: \.self) { type in
                        Text("\(type)")
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .clipped()
                
                // RIR
                HStack {
                    Text("RIR")
                        .padding(.horizontal, 5)
                    
                    Picker("RIR", selection: $set.rir) {
                        ForEach(Array(0...5), id: \.self) { rir in
                            Text("\(rir)")
                                .tag(rir)
                        }
                    }
                    .pickerStyle(.segmented)
                    .clipped()
                }
            }
            .padding()
            .toolbar {
                if exerciseStatus >= 1 {
                    Button {
                        exerciseStatus = 3
                        isPresented = false
                    } label: {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                    }
                    
                    Button {
                        exerciseStatus = 2
                        isPresented = false
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    EditSet(set: Binding(get: { return ExerciseSet() }, set: { _ in }))
}
