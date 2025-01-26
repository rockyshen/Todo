//
//  TodoList.swift
//  Todo
//  这个视图，就只展示纯粹的：列表展示每一条todo
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI

struct TodoList: View {
    // @Binding:作用于一些基本数据类型：Todo, Int, Bool
    // @Bindable：专门给Observable的class服务
    @Bindable var todoStore: TodoStore     // 绑定contentView传递过来的todoStore
    
    @State var editingTodo: Todo?
    
    var body: some View {
        List {
            ForEach($todoStore.todos) {todo in
                TodoView(
                    emoji: todo.wrappedValue.emoji,     // @Bindable绑定的数据，需要用wrappedValue解包出来。
                    title: todo.wrappedValue.title,
                    dueDate: todo.wrappedValue.dueDate,
                    isDone: todo.wrappedValue.isDone)
                .swipeActions(edge: .leading){
                    Button("Edit"){
                        //实现编辑页的跳转逻辑
                        editingTodo = todo.wrappedValue
                    }.tint(.indigo)
                }                
                .swipeActions(edge: .trailing){
                    Button("Delete",role: .destructive){
                        //实现删除逻辑
                        todoStore.delete(todo: todo.wrappedValue)
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
                    completion: {newTodo in todoStore.updateTodo(todo: newTodo)}
                )
            }
        )
    }
}

//#Preview {
//    TodoList()
//}
