//
//  AddCheckList.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 10/10/24.
//

import SwiftData
import SwiftUI

struct AddCheckList: View {
    let todo: ToDo

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var enableSaveButton: Bool = false
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Description", text: $description)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveCheckList()
                    dismiss()
                }.disabled(!isFormValid())
            }

        }
        
    }
    
    private func saveCheckList() {
        let newCheckList: CheckList = .init(title: title, details: description)
        newCheckList.todo = todo
        
        context.insert(newCheckList)
        todo.checkList.append(newCheckList)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func isFormValid() -> Bool {
        if !title.isEmpty , !description.isEmpty { return true }
        return false
    }
}
