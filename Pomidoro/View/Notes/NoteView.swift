//
//  NoteView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 27.04.2022.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.managedObjectContext) var moc

    @ObservedObject var note: Note

    @State private var title: String
    @State private var text: String

    var body: some View {
        VStack(alignment: .leading) {

            Section {
                TextField("Title", text: $title)
                    .font(.title)
                    .textFieldStyle(.roundedBorder)
//                    .padding()
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 10)
//                            .strokeBorder(.gray)
//                    }
            }
            .padding(.horizontal)

            Divider()

            Section {
                TextEditor(text: $text)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.gray)
                            .opacity(0.7)
                    }
            }
            .padding(.horizontal)

            Spacer()
        }
        .onChange(of: title) { _ in
            note.title = title
            try? moc.save()
        }
        .onChange(of: text) { _ in
            note.text = text
            try? moc.save()
        }
    }

    init(note: Note) {
        self.note = note
        title = note.wrappedTitle
        text = note.wrappedText
    }
}
