//
//  Task+CoreDataProperties.swift
//  Pomidoro
//
//  Created by Антон Таранов on 26.04.2022.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var numberOfPomidoro: Int32
    @NSManaged public var completeNumberOfPomidoro: Int32
    @NSManaged public var isComplete: Bool

    var wrappedName: String {
        name ?? "Unknown"
    }
}

extension Task: Identifiable {

}
