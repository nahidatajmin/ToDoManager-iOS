//
//  AddToDoItem.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 6/10/24.
//

import SwiftUI

struct AddToDoItem: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    private func isValid() -> Bool {
        if !title.isEmpty, !description.isEmpty {
            return true
        }
        return false
    }
    
    private func saveTodoItem() {
        let itemToBeSaved = ToDo(name: title, note: description)
        context.insert(itemToBeSaved)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        Form {
            TextField("title", text: $title)
            TextField("Description", text: $description)
        }
        .navigationTitle("Add ToDo Item")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveTodoItem()
                    dismiss()
                }.disabled(!isValid())
            }
        }
    }
}

#Preview {
    AddToDoItem()
        .modelContainer(for: [ToDo.self])
}
