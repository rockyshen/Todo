//
//  TodoStore.swift
//  Todo
//
//  Created by 沈俊杰 on 2025/1/24.
//

import Foundation

struct Todo: Identifiable,Equatable,Codable {
    var id: UUID = UUID()
    var emoji: String
    var title: String
    var dueDate: Date
    var isDone: Bool
    
    // 如何自动生成可比较协议的实现方法？
    
}

@Observable
class TodoStore{
    var todos: [Todo] = []{
        didSet {              // 属性一有更新，就出发持久话保存
            saveTodos()
        }
    }   // :ObserveObject + @Published
    
    // mock模拟一些数据
    init() {
//        todos = [
//            .init(emoji: "⌨️", title: "写代码",dueDate: .now, isDone: false),
//            .init(emoji: "💃", title: "跳舞",dueDate: .now, isDone: true),
//            .init(emoji: "🏃", title: "跑步",dueDate: .now, isDone: false)
//        ]
        loadTodos()
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
    
    // 增加
    func addTodo(todo: Todo) {
        todos.append(todo)
    }
    
    // 【FileManager】将todos保存在沙盒中
    func saveTodos() {
        do {
            let todoData = try JSONEncoder().encode(todos)
            let url = URL.documentsDirectory.appending(path: "Todos")
            print(url)
            try todoData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    // 【FileManager】从沙盒中读取todos
    func loadTodos() {
        let url = URL.documentsDirectory.appending(path: "Todos")
        do {
            let todoData = try Data(contentsOf: url)
            let todos = try JSONDecoder().decode([Todo].self, from: todoData)
            self.todos = todos   // 从本地文件读取并解码的todos，赋值给属性
        } catch {
            print(error)
        }
    }

}
