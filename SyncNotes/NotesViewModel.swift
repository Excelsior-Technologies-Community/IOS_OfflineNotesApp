//
//  NotesViewModel.swift
//  SyncNotes
//
//  Created by Noman belim on 30/01/26.
//

import Foundation
import Foundation

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []

    private let storage = LocalStorageService.shared
    private let syncService = SyncService()

    init() {
        loadNotes()
    }

    func loadNotes() {
        notes = storage.loadNotes()
    }

    func addNote(title: String, content: String) {
        let note = Note(
            id: UUID(),
            title: title,
            content: content,
            updatedAt: Date(),
            isDirty: true
        )
        notes.insert(note, at: 0)
        save()
    }

    func update(note: Note) {
        if let index = notes.firstIndex(of: note) {
            notes[index].updatedAt = Date()
            notes[index].isDirty = true
            save()
        }
    }

    func save() {
        storage.saveNotes(notes)
    }

    func sync() {
        notes = syncService.sync(localNotes: notes)
        save()
    }
}
