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
In order to get the sorted order `SwiftData` provides a particular syntax.
```Swift
sort: \ToDo.name,  order: .forward
```
Here, `\ToDO.name` indicates the sorting criteria and `order: .forward` denotes the sorting order i.e ascending or descending.

To delete a particular entry SwiftData provides `delete` function.


![Simulator Screen Recording - iPhone 16 - 2024-10-14 at 23 43 39](https://github.com/user-attachments/assets/d3eb621b-791f-41ae-a2b7-a413c799d493)





```Swift
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
                ToDoDetailsScreen(todo: todolist)
            }
        }.navigationTitle("ToDo Lists")
            .toolbar {
                Button("add samples") {
                    isAddTodoItemPresented = true
                }
            }.sheet(isPresented: $isAddTodoItemPresented, content: {
                NavigationStack {
                    AddToDoItem()
                }.presentationDetents([.large])
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
```

Here `try catch` block is not mandatory. `Context.delete` method is enough to do the deletion process for SwiftData.
Though it is a good practice to catch the error and print the log for debugging purposes.



