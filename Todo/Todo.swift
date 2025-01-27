//
//  Todo.swift
//  Todo
//  将TodoStore改为SwiftData存储
//  Created by 沈俊杰 on 2025/1/27.
//

import Foundation
import SwiftData

@Model
class Todo: Identifiable,Equatable {
    var id: UUID = UUID()
    var emoji: String
    var title: String
    var dueDate: Date
    var isDone: Bool
    
    // 如何自动生成可比较协议的实现方法
    
    init(id: UUID = UUID(), emoji: String, title: String, dueDate: Date, isDone: Bool) {
        self.id = id
        self.emoji = emoji
        self.title = title
        self.dueDate = dueDate
        self.isDone = isDone
    }
    
}
