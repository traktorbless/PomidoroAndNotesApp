//
//  Task+CoreDataProperties.swift
//  Pomidoro
//
//  Created by Антон Таранов on 10.05.2022.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var completeNumberOfPomidoro: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var numberOfPomidoro: Int16
    @NSManaged public var minuteOfProgress: Int16
    @NSManaged public var secondOfProgress: Int16
    @NSManaged public var statusOfTime: String?
    @NSManaged public var taskMinuteOfPomidoro: Int16
    @NSManaged public var taskMinuteOfPause: Int16
    @NSManaged public var timeOfCloseTimer: Date?
    @NSManaged public var statusOfButton: String?

    var wrappedName: String {
        name ?? "Unknown"
    }

    var wrappedStatusOfPomidoro: String {
        statusOfTime ?? "Pomidoro"
    }

    var progress: Double {
        1.0 - Double(minuteOfProgress * 60 + secondOfProgress) / Double((statusOfTime == "Pomidoro" ? taskMinuteOfPomidoro : taskMinuteOfPause) * 60)
    }
}

extension Task: Identifiable {

}
