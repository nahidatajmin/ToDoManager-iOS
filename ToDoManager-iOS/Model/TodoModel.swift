//
//  Model.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 6/10/24.
//

import SwiftData
import SwiftUI

@Model
class ToDo {
   // @Attribute(.unique) var id: String = UUID().uuidString
    var name: String
    var note: String
    
    @Relationship(deleteRule: .cascade) var checkList: [CheckList] = []
    
    init(name: String, note: String) {
        self.name = name
        self.note = note
    }
}
