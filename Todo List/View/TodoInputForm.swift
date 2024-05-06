//
//  TodoInputForm.swift
//  Todo List
//
//  Created by Mohanraj on 04/05/24.
//

import SwiftUI

struct TodoInputForm: View {
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) var viewContext
    @State var todo: Todos?
    
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var status: TodoStatus = .pending
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter todo title", text: $title)
                } header: {
                    Text("Title")
                }
                
                Section {
                    DatePicker("Select a date", selection: $date, displayedComponents: .date)
                } header: {
                    Text("Date")
                }
                
                Section {
                    Picker("Select status", selection: $status) {
                        ForEach(TodoStatus.allCases, id: \.self) { status in
                            Text(status.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Status")
                }
                
            }
            .navigationTitle(((todo?.title?.isEmpty) != nil) ? "New Todo" : "Edit Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        self.saveTodo(title: title, date: date, status: status.rawValue)
                        isPresented = false
                    }
                }
            }
            .onAppear {
                if let todo = todo {
                    self.title = todo.title!
                    self.date = todo.date!
                    self.status = todo.status! == "completed" ? .completed : .pending
                }
            }
        }
    }
    
    func saveTodo(title: String, date: Date, status: String) {
        if todo == nil {
            todo = Todos(context: self.viewContext)
            todo?.id = UUID()
        }
        todo?.title = title
        todo?.date = date
        todo?.status = status
        
        do {
            try self.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
