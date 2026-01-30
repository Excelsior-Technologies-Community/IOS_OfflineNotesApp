//
//  AddEditNoteView.swift
//  SyncNotes
//
//  Created by Noman belim on 30/01/26.
//

import Foundation
import SwiftUI

struct AddEditNoteView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: NotesViewModel

    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
            }
            .navigationTitle("New Note")
            .toolbar {
                Button("Save") {
                    vm.addNote(title: title, content: content)
                    dismiss()
                }
            }
        }
    }
}
