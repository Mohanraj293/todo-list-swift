//
//  Todo_ListApp.swift
//  Todo List
//
//  Created by Mohanraj on 21/04/24.
//

import SwiftUI

@main
struct Todo_ListApp: App {
    @StateObject private var manager: DataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
