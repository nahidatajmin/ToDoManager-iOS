//
//  ToDoManager_iOSApp.swift
//  ToDoManager-iOS
//
//  Created by Kazi Tanjim Shakib on 6/10/24.
//

import SwiftData
import SwiftUI

@main
struct ToDoManager_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }.modelContainer(for: [ToDo.self])
    }
}
