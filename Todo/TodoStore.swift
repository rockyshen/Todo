//
//  TodoStore.swift
//  Todo
//
//  Created by 沈俊杰 on 2025/1/24.
//

import Foundation

struct Todo: Identifiable,Equatable {
    var id: UUID = UUID()
    var emoji: String
    var title: String
    var dueDate: Date
    var isDone: Bool
    
    // 如何自动生成可比较协议的实现方法？
    
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
    // 删除一条todo
    func delete(todo: Todo){
        // 找到存在的todo的index
        guard let index = todos.firstIndex(where: {$0.id == todo.id} ) else { return }

        // 从数组中移除
        todos.remove(at: index)
    }
    
    func moveTodos(fromOffsets: IndexSet, toOffset: Int){
        todos.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    // 更新
    func updateTodo(todo: Todo){
        guard let index = todos.firstIndex(where: {$0.id == todo.id}) else {return}
        todos[index] = todo
    }

}
