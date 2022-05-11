import SwiftUI

struct NoteList: View {
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var notesApp: NotesViewModel

    var body: some View {
        if !notes.isEmpty {
            List {
                ForEach(notes) { note in
                    NoteRow(note: note, notesApp: notesApp)
                }
                .onDelete(perform: { indexSet in
                    notesApp.deleteNote(at: indexSet, notes: notes, moc: moc)
                })
                .listRowSeparator(.hidden)
            }
        } else {
            Text("List of notes is empty")
                .font(.title)
                .foregroundColor(.secondary)
        }
    }
}
