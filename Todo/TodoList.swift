//
//  TodoList.swift
//  Todo
//  这个视图，就只展示纯粹的：列表展示每一条todo
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI

struct TodoList: View {
    @StateObject var todoStore = TodoStore()
    
    var body: some View {
        List {
            ForEach(todoStore.todos) {todo in
                TodoView(
                    emoji: todo.emoji,
                    title: todo.title,
                    dueDate: todo.dueDate,
                    isDone: todo.isDone)
            }
        }
    }
}

#Preview {
    TodoList()
}
