//
//  ShowCheckList.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 10/10/24.
//

import SwiftUI

struct ShowCheckList: View {
    @Environment(\.modelContext) private var context
    let todo: ToDo
    
    var body: some View {
        List {
            ForEach(todo.checkList) { checklist in
                VStack(alignment: .leading) {
                    Text(checklist.title).bold()
                    Text(checklist.details).fontDesign(.serif)
                }
            }.onDelete(perform: deleteCheckList)
        }
    }
    
    private func deleteCheckList(indexSet: IndexSet) {
        indexSet.forEach { index in
            
            let checkList = todo.checkList[index]
            context.delete(checkList)
            
            do {
                todo.checkList.remove(at: index)
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }

    }
}

#Preview {
    ShowCheckList(todo: .init(name: "sample title", note: "sample description"))
}
