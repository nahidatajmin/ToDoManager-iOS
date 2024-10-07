//
//  ToDoDetailsScreen.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 6/10/24.
//

import SwiftData
import SwiftUI

struct ToDoDetailsScreen: View {
    let todo: ToDo
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    private func shouldEnableUpdateButton() -> Bool {
        if todo.name != title || todo.note != description {
            return true
        }
        
        return false
    }
    
    private func updateTodoItem() {
        todo.name = title
        todo.note = description
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        Form {
            TextField("title", text: $title)
            TextField("description", text: $description)
            Button("Update") {
                updateTodoItem()
            }.disabled(!shouldEnableUpdateButton())
        }.onAppear {
            title = todo.name
            description = todo.note
        }
    }
}

#Preview {
    ToDoDetailsScreen(todo: .init(name: "sampleName", note: "Sample Description"))
}
