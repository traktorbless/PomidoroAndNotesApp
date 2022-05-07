//
//  NotesView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 25.04.2022.
//

import SwiftUI

struct NotesView: View {
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NoteRow(note: note)
                }
                .onDelete(perform: deleteNote)
            }
            .navigationTitle("Notes")
            .toolbar {
                Button {
                    _ = Note(context: moc)
                    try? moc.save()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        for offset in offsets {
            let note = notes[offset]
            
            moc.delete(note)
        }
        
        try? moc.save()
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
