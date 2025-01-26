//
//  ContentView.swift
//  Todo
//  总视图：导航栏
//  Created by 沈俊杰 on 2025/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingAddView: Bool = false
    
    @State private var todoStore = TodoStore()    // 全局应该只初始化一个todoStore实例
    
    var body: some View {
        NavigationView {
            TodoList(todoStore: todoStore)
                .navigationTitle("Todo List")
                .safeAreaInset(edge: .bottom) {
                    Button(action: {
                        // 添加Todo按钮的具体逻辑
                        isShowingAddView.toggle()
                    }, label: {
                        HStack(spacing: 12){
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                            Text("Add")
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
                .sheet(
                    isPresented: $isShowingAddView,  // Bool类型，直接返回一个View，区别于Optinal类型
                    content: { TodoAddView(
                        completion: {newTodo in todoStore.addTodo(todo: newTodo)})
                    }
                
                )
        }

    }
}

#Preview {
    ContentView()
}
