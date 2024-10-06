//
//  ContentView.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 6/10/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \ToDo.name, order: .forward) var allToDoLists: [ToDo]
    
    @State private var isAddTodoItemPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allToDoLists) { list in
                    NavigationLink(value: list) {
                        HStack {
                            Text("\(list.name)")
                            Spacer()
                            Text("\(list.note)")
                        }
                    }
                }.onDelete(perform: deleteTodo)
            }.navigationDestination(for: ToDo.self) { todolist in
                ToDoDetailsScreen()
            }
        }.navigationTitle("ToDo Lists")
            .toolbar {
                Button("add samples") {
                    isAddTodoItemPresented = true
                    //addSamples()
                }
            }.sheet(isPresented: $isAddTodoItemPresented, content: {
                NavigationStack {
                    AddToDoItem()
                }.presentationDetents([.medium, .large])
            })
    }
    
    private func deleteTodo(indexSet: IndexSet) {
        indexSet.forEach { index in
            let TodoItem = allToDoLists[index]
            context.delete(TodoItem)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [ToDo.self])
}
