//
//  Note+CoreDataProperties.swift
//  Pomidoro
//
//  Created by Антон Таранов on 26.04.2022.
//
//

import Foundation
import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?

    var wrappedTitle: String {
        title ?? "Unknown title"
    }

    var wrappedText: String {
        text ?? "Empty"
    }

}

extension Note: Identifiable {

}
