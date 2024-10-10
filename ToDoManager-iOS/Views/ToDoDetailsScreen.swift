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
    @State private var shouldAddCheckListPresent: Bool = false
    
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
            
            Section("Checklist of this task") {
                Button {
                    shouldAddCheckListPresent = true
                } label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                if todo.checkList.isEmpty {
                    ContentUnavailableView("No Checklists so far", systemImage: "trash.fill")
                } else {
                    ShowCheckList(todo: todo)
                }
                
            }
        }.onAppear {
            title = todo.name
            description = todo.note
        }
        .sheet(isPresented: $shouldAddCheckListPresent) {
            NavigationStack {
                AddCheckList(todo: todo)
            }
        }
    }
}

#Preview {
    ToDoDetailsScreen(todo: .init(name: "sampleName", note: "Sample Description"))
}
