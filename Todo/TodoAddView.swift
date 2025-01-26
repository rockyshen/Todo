//
//  TodoAddView.swift
//  Todo
//
//  Created by 沈俊杰 on 2025/1/26.
//

import SwiftUI

struct TodoAddView: View {
    @State var todo: Todo = .init(emoji: "", title: "", dueDate: .now, isDone: false)
    
    @Environment(\.dismiss) private var dismiss   // 关闭sheet弹出页面
    
    let completion: (Todo) -> Void            // 更新后的Todo
    
    var body: some View {
        NavigationStack {
            List(){
                Group{    // 统一给它们添加padding的效果
                    TextField("Emoji", text: $todo.emoji)
                    TextField("Title", text: $todo.title)
                    DatePicker("Due Date", selection: $todo.dueDate, displayedComponents: .date)
                    Toggle("isDone", isOn: $todo.isDone)
                }
                .padding(.vertical,8)
            }
            .navigationTitle("Add Todo")
            
            // TODO Done完成按钮
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    // 完成按钮的具体逻辑
                    // 1.关闭Add页面；2、将数据往父目录提交
                    dismiss()
                    completion(todo)
                }, label: {
                    HStack(spacing: 12){
                        Text("Done")
                            .padding(.vertical,12)
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth:.infinity, alignment:.center)
                    .background(.indigo)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                })
                .padding(.horizontal,16)
                .padding(.bottom,8)
            }
        }
    }
}

#Preview {
    TodoAddView(todo: .init(
        emoji: "🍉",
        title: "吃西瓜",
        dueDate: .now,
        isDone: false),
        completion: {newTodo in print(newTodo.emoji)})
    
}
