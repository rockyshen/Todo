//
//  TodoStore.swift
//  Todo
//
//  Created by 沈俊杰 on 2025/1/24.
//

import Foundation

struct Todo: Identifiable,Equatable,Encodable,Decodable {
    var id: UUID = UUID()
    var emoji: String
    var title: String
    var dueDate: Date
    var isDone: Bool
    
    // 如何自动生成可比较协议的实现方法？
}

@Observable
class TodoStore{
    // :ObserveObject + @Published
    var todos: [Todo] = [] {
        // 属性被修改后执行，适合的场景：存入沙盒
        didSet {
            saveTodos()
        }
    }
    
    // mock模拟一些数据
    init() {
        // 从原来默认数据，改为从沙盒中获取数据
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
    
    // 数据保存到沙盒中
    func saveTodos() {
        // 可存储的数据类型：基本数据类型：Bool、String等；序列化的Data类型
        // 参数1:todos   参数2:key
        do {
            let todoData = try JSONEncoder().encode(todos)        // 序列化
            UserDefaults.standard.set(todoData, forKey: "Todos")
        } catch {
            print(error)
        }
    }
    
    // 从沙盒中取数据
    func loadTodos() {
        guard let todoData = UserDefaults.standard.data(forKey: "Todos") else {return}
        do {
            let todos = try JSONDecoder().decode([Todo].self, from: todoData)
            self.todos = todos
        } catch {
            print(error)
        }
    }

}
