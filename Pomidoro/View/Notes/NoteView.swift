import SwiftUI

struct NoteView: View {
    @Environment(\.managedObjectContext) var moc

    @ObservedObject var note: Note
    @ObservedObject var notesApp: NotesViewModel

    @State private var title: String
    @State private var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Section {
                TextField("Title", text: $title)
                    .font(.largeTitle)
                    .frame(height: 50)
                    .roundedRectangleBorder(style: .gray, cornerRadius: 10, lineWidth: 1)
                    .padding(.horizontal)
            }

            Divider()

            Section {
                TextEditor(text: $text)
                    .font(.title3)
                    .roundedRectangleBorder(style: .gray, cornerRadius: 10, lineWidth: 1)
            }
            .padding(.horizontal)

            Spacer()
        }
        .onDisappear {
            notesApp.updateNote(note: note, title: title, text: text, moc: moc)
        }
    }

    init(notesApp: NotesViewModel, note: Note) {
        self.note = note
        self.notesApp = notesApp
        title = note.wrappedTitle
        text = note.wrappedText
    }
}
