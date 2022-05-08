//
//  NoteRow.swift
//  Pomidoro
//
//  Created by Антон Таранов on 27.04.2022.
//

import SwiftUI

struct NoteRow: View {
    @ObservedObject var note: Note
    @ObservedObject var notesApp: NotesViewModel

    var body: some View {
        HStack {
            Text(note.wrappedTitle)
                .font(.headline)
                .padding(.vertical)

            Spacer()

            NavigationLink {
                NoteView(notesApp: notesApp, note: note)
            } label: {
                Text("")
            }
        }
        .roundedRectangleBorder(style: .yellow, cornerRadius: 15, lineWidth: 2)
    }
}
