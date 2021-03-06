import SwiftUI

struct NotesView: View {
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var notesApp: NotesViewModel

    var body: some View {
        NavigationView {
            VStack {
                NoteList(notesApp: notesApp)
                    .listStyle(.plain)
                    .navigationTitle("Notes")
                    .toolbar {
                        Button {
                            notesApp.addNote(moc: moc)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.yellow)
                        }
                    }
            }
        }
    }
}
