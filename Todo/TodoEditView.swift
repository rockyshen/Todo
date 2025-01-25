//
//  TodoEditView.swift
//  Todo
//
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI

struct TodoEditView: View {
    @State var todo: Todo
    
    @Environment(\.dismiss) private var dismiss   // 关闭sheet弹出页面
    
    let updatedTodo: (Todo) -> Void     // updatedTodo属性，是一个闭包函数，传递一个Todo类型的值，什么也不返回
    
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
            .navigationTitle("Edit Todo")
            
            // TODO Done完成按钮
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    // 完成按钮的具体逻辑
                    // 1.关闭Edit页面；2、将数据往父目录提交
                    dismiss()
                    updatedTodo(todo)
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
    TodoEditView(
        todo: .init(
            emoji: "⌨️",
            title: "写代码",
            dueDate: .now,
            isDone: false
        ),
        updatedTodo: { todo in                    
            // 此处写在()后面的{}，也是闭包的特性，可以作为另一个闭包类型的参数，进行初始化
            print("来自TodoEditView的执行，结果为：\(todo.emoji)")
        }
    )
}
