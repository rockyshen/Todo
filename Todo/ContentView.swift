//
//  ContentView.swift
//  Todo
//  总视图：导航栏
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TodoList().navigationTitle("Todo List")
        }
    }
}

#Preview {
    ContentView()
}
