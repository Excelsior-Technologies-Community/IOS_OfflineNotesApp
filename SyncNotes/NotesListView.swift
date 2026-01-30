//
//  NotesListView.swift
//  SyncNotes
//
//  Created by Noman belim on 30/01/26.
//

import Foundation
import SwiftUI

struct NotesListView: View {
    @StateObject private var vm = NotesViewModel()
    @State private var showAdd = false

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.notes) { note in
                    NoteRowView(note: note)
                }
            }
            .navigationTitle("Offline Notes")
            .toolbar {
                Button("Sync") {
                    vm.sync()
                }
                Button("+") {
                    showAdd = true
                }
            }
            .sheet(isPresented: $showAdd) {
                AddEditNoteView(vm: vm)
            }
        }
    }
}
