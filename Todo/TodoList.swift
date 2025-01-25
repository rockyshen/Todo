//
//  TodoList.swift
//  Todo
//  这个视图，就只展示纯粹的：列表展示每一条todo
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI

struct TodoList: View {
    @StateObject var todoStore = TodoStore()
    
    @State var editingTodo: Todo?
    
    var body: some View {
        List {
            ForEach(todoStore.todos) {todo in
                TodoView(
                    emoji: todo.emoji,
                    title: todo.title,
                    dueDate: todo.dueDate,
                    isDone: todo.isDone)
                .swipeActions(edge: .leading){
                    Button("Edit"){
                        //实现编辑页的跳转逻辑
                        editingTodo = todo
                    }.tint(.indigo)
                }                
                .swipeActions(edge: .trailing){
                    Button("Delete",role: .destructive){
                        //实现删除逻辑
                        todoStore.delete(todo: todo)
                    }
                }
            }
            // indices表示当前位置1开始，newOffset表示目标位置
            .onMove(perform: { indices, newOffset in
                todoStore.moveTodos(fromOffsets: indices, toOffset: newOffset)
            })
        }
        .sheet(
            item: $editingTodo,
            content: { todo in
                TodoEditView(
                    todo: todo,
                    updatedTodo: { newTodo in
//                        print("来自TodoList的执行，结果为：\(newTodo.title)")
                        todoStore.updateTodo(todo: newTodo)
                    }
                )
            }
        )
    }
}

#Preview {
    TodoList()
}
