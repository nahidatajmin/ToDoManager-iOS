//
//  CheckListModel.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 10/10/24.
//

import SwiftData

@Model
class CheckList {
    var title: String
    var details: String
    
    var todo: ToDo?
    
    init(title: String, details: String) {
        self.title = title
        self.details = details
    }
}
