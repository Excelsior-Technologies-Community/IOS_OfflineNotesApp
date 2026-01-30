//
//  SyncService.swift
//  SyncNotes
//
//  Created by Noman belim on 30/01/26.
//

import Foundation
import Foundation

class SyncService {

    // Simulated server storage
    private var serverNotes: [Note] = []

    func sync(localNotes: [Note]) -> [Note] {
        guard NetworkMonitor.shared.isConnected else {
            print("❌ No internet, sync skipped")
            return localNotes
        }

        var updatedLocalNotes = localNotes

        // 1️⃣ Upload dirty notes
        for note in localNotes where note.isDirty {
            if let index = serverNotes.firstIndex(where: { $0.id == note.id }) {
                // Conflict resolution → last updated wins
                if note.updatedAt > serverNotes[index].updatedAt {
                    serverNotes[index] = note
                }
            } else {
                serverNotes.append(note)
            }
        }

        // 2️⃣ Download server notes
        for serverNote in serverNotes {
            if let index = updatedLocalNotes.firstIndex(where: { $0.id == serverNote.id }) {
                if serverNote.updatedAt > updatedLocalNotes[index].updatedAt {
                    updatedLocalNotes[index] = serverNote
                }
            } else {
                updatedLocalNotes.append(serverNote)
            }
        }

        // 3️⃣ Mark everything clean
        updatedLocalNotes = updatedLocalNotes.map {
            var note = $0
            note.isDirty = false
            return note
        }

        print("✅ Sync completed")
        return updatedLocalNotes
    }
}
