//
//  TodoStore.swift
//  Todo
//
//  Created by 沈俊杰 on 2025/1/24.
//

import Foundation

struct Todo: Identifiable {
    var id: String { title }
    var emoji: String
    var title: String
    var dueDate: Date
    var isDone: Bool
}

class TodoStore: ObservableObject{
    @Published var todos: [Todo] = []
    
    // mock模拟一些数据
    init() {
        todos = [
            .init(emoji: "⌨️", title: "写代码",dueDate: .now, isDone: false),
            .init(emoji: "💃", title: "跳舞",dueDate: .now, isDone: true),
            .init(emoji: "🏃", title: "跑步",dueDate: .now, isDone: false)
        ]
    }
    
    // func
}
