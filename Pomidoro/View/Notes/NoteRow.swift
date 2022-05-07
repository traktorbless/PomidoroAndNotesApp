//
//  NoteRow.swift
//  Pomidoro
//
//  Created by Антон Таранов on 27.04.2022.
//

import SwiftUI

struct NoteRow: View {
    @ObservedObject var note: Note

    var body: some View {
        HStack {
            Text(note.wrappedTitle)
                .font(.headline)

            Spacer()

            NavigationLink {
                NoteView(note: note)
            } label: {
                Text("")
            }
        }
    }
}
