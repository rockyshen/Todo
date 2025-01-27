//
//  TodoList.swift
//  Todo
//  这个视图，就只展示纯粹的：列表展示每一条todo
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI
import SwiftData

struct TodoList: View {
    // @Binding:作用于一些基本数据类型：Todo, Int, Bool
    // @Bindable：专门给Observable的class服务
    // @Bindable var todoStore: TodoStore
    // 绑定contentView传递过来的todoStore
    
    @Query var todos: [Todo]
    
    @State var editingTodo: Todo?
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            ForEach(todos) {todo in
                TodoView(todo: todo)
                .swipeActions(edge: .leading){
                    Button("Edit"){
                        //实现编辑页的跳转逻辑
                        editingTodo = todo
                    }.tint(.indigo)
                }                
                .swipeActions(edge: .trailing){
                    Button("Delete",role: .destructive){
                        //实现删除逻辑
                        // todoStore.delete(todo: todo.wrappedValue)
                        // 改为SwiftData的删除操作
                        modelContext.delete(todo)
                        try? modelContext.save()
                    }
                }
            }
            // indices表示当前位置1开始，newOffset表示目标位置
            .onMove(perform: { indices, newOffset in
                // todoStore.moveTodos(fromOffsets: indices, toOffset: newOffset)
                //TODO 基于SwiftData实现数组中移动位置
            })
        }
        .sheet(
            item: $editingTodo,   // Optional类型，content获取todo值，再返回View
            content: { todo in
                TodoEditView(
                    todo: todo
                )
            }
        )
    }
}

#Preview {
    TodoList()
}
