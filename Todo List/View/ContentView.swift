//
//  ContentView.swift
//  Todo List
//
//  Created by Mohanraj on 21/04/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) var viewContext
    @State var searchKeyword: String = ""
    @State var isSheetPresented: Bool = false
    @FetchRequest(sortDescriptors: []) private var todos: FetchedResults<Todos>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos, id: \.self) { todo in
                    NavigationLink(destination: TodoDetailView(todo: todo)) {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text(todo.title ?? "")
                                    .font(.title3)
                                Text(formatDate(todo.date ?? Date()))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            StatusIndicator(status: todo.status == "completed" ? .completed : .pending)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(.automatic)
            .navigationTitle("Todo List")
            .searchable(text: $searchKeyword)
            .onChange(of: searchKeyword) { newValue, _ in
                self.todos.nsPredicate = newValue.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS %@", newValue)
            }
            .sheet(
                isPresented: $isSheetPresented,
                content: {
                    TodoInputForm(isPresented: $isSheetPresented)
                }
            )
            .toolbar {
                Button("Add") {
                    isSheetPresented.toggle()
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            self.viewContext.delete(todo)
            do {
                try viewContext.save()
            } catch {
                print("whoops \(error.localizedDescription)")
            }
        }
    }
}
#Preview {
    ContentView()
}
