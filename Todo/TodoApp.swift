//
//  TodoApp.swift
//  Todo
//
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI
import SwiftData

@main
struct TodoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Todo.self)
        }
    }
}
