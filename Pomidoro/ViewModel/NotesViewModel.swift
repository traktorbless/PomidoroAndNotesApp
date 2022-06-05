import Foundation
import CoreData
import SwiftUI

class NotesViewModel: ObservableObject {

    func addNote(moc: NSManagedObjectContext) {
        _ = Note(context: moc)
        try? moc.save()
    }

    func deleteNote(at offsets: IndexSet, notes: FetchedResults<Note>, moc: NSManagedObjectContext) {
        for offset in offsets {
            let note = notes[offset]

            moc.delete(note)
        }
        try? moc.save()
    }

    func updateNote(note: Note, title: String, text: String, moc: NSManagedObjectContext) {
        note.title = title
        note.text = text
        try? moc.save()
    }
}
