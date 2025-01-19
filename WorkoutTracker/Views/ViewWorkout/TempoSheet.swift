//
//  TempoSheet.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/18/25.
//

import SwiftUI

struct TempoSheet: View {
    private var arr: [String]
    @State private var slot: Int = 0
    @State private var text: String = ""
    
    init (tempo: String = "XXXX") {
        arr = tempo.map { String($0) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(arr[0]): Eccentric (Lowering/Lenthening)")
                    .padding(1)
                Text("\(arr[1]): Lengthened Pause (Fully Stretched)")
                    .padding(1)
                Text("\(arr[2]): Concentric (Lifting/Shortening)")
                    .padding(1)
                Text("\(arr[3]): Shortened Pause (Fully Shortened)")
                    .padding(1)
                
                Text("0/X = Instant")
                    .padding(1)
                    .italic(true)
                    .font(.subheadline)
                
                Spacer()
            }
            .padding(.top, 25)
        }
    }
}

#Preview {
    TempoSheet()
}
