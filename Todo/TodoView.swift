//
//  TodoView.swift
//  Todo
//  单条Todo代办事项的视图
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI

struct TodoView: View {
    // TODO 如果model比较复杂，或者经常变化的话，这里应该是传递Todo的Field，封装一下，这里不改了
//    let emoji: String
//    let title: String
//    let dueDate: Date
//    // 子视图，与父视图同步变量
//    @State var isDone: Bool
    @Binding var todo: Todo
    
    var body: some View {
        HStack(spacing: 5) {
            // emoji
            Text(todo.emoji)
                .padding(8)
                .background {Color.indigo.opacity(0.3)}
                .clipShape(Circle())
            
            // Todo项
            VStack(alignment: .leading, spacing: 8){
                Text(todo.title)
                    .foregroundStyle(todo.isDone ? .gray.opacity(0.5) : .primary)
                    .strikethrough(todo.isDone)
                HStack(spacing: 5) {
                    Image(systemName: "calendar.badge.clock")
                    Text(todo.dueDate,format: Date.FormatStyle(date: .numeric))
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            
            // 中间空的填充
            Spacer()
            
            // checkbox
            Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                .imageScale(.large)
                .foregroundColor(.indigo)
                .contentTransition(.symbolEffect(.replace))
        }
        .padding(.horizontal,16)
        .padding(.vertical,8)
        .contentShape(Rectangle())
        .onTapGesture {
            todo.isDone.toggle()
        }
    }
}

// 可以看作是本页View的单元测试
//#Preview {
////    @Previewable @State var isTodo1Done = false
////    @Previewable
////    @State var isTodo2Done = true
//    
//    VStack {
//        TodoView(emoji: "🏊", title: "游泳",dueDate: .now, isDone: true)
//        TodoView(emoji: "📖", title: "看书",dueDate: .now, isDone: false)
//    }
//    
//}
