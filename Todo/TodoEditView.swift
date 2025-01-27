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
    
    // 编辑完成后的回调操作！
    // 将这个Filed名为completion的属性，定义成一个闭包函数方法，每次实例化的时候需要实现具体怎么执行
    // 函数的参数是一个Edit页面传递给我们的Todo新对象
//    let completion: (Todo) -> Void
    @Environment(\.modelContext) var modelContext
    
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
                    // 1.关闭Edit页面；
                    dismiss()
//                    completion(todo)
                    // 2、数据利用SwiftData存入
                    try? modelContext.save()
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
        )
//        completion: { todo in
//            // 此处写在()后面的{}，也是闭包的特性，可以作为另一个闭包类型的参数，进行初始化
//            print("来自TodoEditView的执行，结果为：\(todo.emoji)")
//        }
    )
}
