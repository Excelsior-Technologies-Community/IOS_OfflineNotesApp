//
//  SyncNotesApp.swift
//  SyncNotes
//
//  Created by Noman belim on 30/01/26.
//  Updated for Firebase
//

import SwiftUI
import FirebaseCore

@main
struct SyncNotesApp: App {
    var body: some Scene {
        WindowGroup {
            NotesListView()
        }
    }
}
