//
//  AddCheckList.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 10/10/24.
//

import SwiftData
import SwiftUI

struct AddCheckList: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    var body: some View {
        Form {
            TextField("ashaf", text: $title)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    dismiss()
                }
            }

        }
        
    }
}

#Preview {
    AddCheckList()
}
