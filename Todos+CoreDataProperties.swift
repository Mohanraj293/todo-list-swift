//
//  Todos+CoreDataProperties.swift
//  Todo List
//
//  Created by Mohanraj on 02/05/24.
//
//

import Foundation
import CoreData


extension Todos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todos> {
        return NSFetchRequest<Todos>(entityName: "Todos")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var status: String?

}

extension Todos : Identifiable {

}
