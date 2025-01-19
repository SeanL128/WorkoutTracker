//
//  Extensions.swift
//  WorkoutTracker
//
//  Created by Sean Lindsay on 1/17/25.
//

import SwiftUI
import SwiftData

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url {
            return "sqlite3 \"\(url.path(percentEncoded: false))\""
        } else {
            return "No SQLite database found. Container configurations: \(container.configurations)"
        }
    }
}

extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue) {
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            }
    }
}
