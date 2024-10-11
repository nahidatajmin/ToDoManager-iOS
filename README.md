# Persisent ToDoManager-iOS Using SwiftUI and SwiftData

This iOS project takes user input as daily ususage data and keep user data persistent.
So SwiftUI is used for whole UI part and for data persistency, SwiftData is used.
SwiftData keeps data synced with iCloud storage.

# App Simulation


https://github.com/user-attachments/assets/a9b78fa1-1cb5-488c-9f9b-1a7a6cbbc02d

## How SwiftData is used to persist user Data.

Need to import `SwiftData` in _Swift_ file.
Need to add `@Model` macro before our model class. It will track this class for data persistency.

 ```Swift
import SwiftData
import SwiftUI

@Model
class ToDo {
    var name: String
    var note: String
    
    @Relationship(deleteRule: .cascade) var checkList: [CheckList] = []
    
    init(name: String, note: String) {
        self.name = name
        self.note = note
    }
}
```

To get the data and to show them in UI, `@Query` macro is used and it's default sort parameter is also used to show data in sorted order.  
`@Environment(\.modelContext)` is needed to make CRUD operation in our project.

```Swift
@Environment(\.modelContext) private var context
@Query(sort: \ToDo.name, order: .forward) var allToDoLists: [ToDo]
```


