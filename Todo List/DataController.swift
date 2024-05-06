//
//  File.swift
//  Todo List
//
//  Created by Mohanraj on 29/04/24.
//

import CoreData
import Foundation

class DataController: NSObject, ObservableObject {
    @Published var todos: [Todos] = [Todos]()
    let container = NSPersistentContainer(name: "TodoModel")
    static let shared = DataController()
    
    override init() {
        super.init()
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
