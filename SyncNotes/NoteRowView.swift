//
//  NoteRowView.swift
//  SyncNotes
//
//  Created by Noman belim on 30/01/26.
//

import Foundation
import SwiftUI

struct NoteRowView: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.headline)
            Text(note.content)
                .font(.subheadline)
                .lineLimit(2)
            if note.isDirty {
                Text("Not synced")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}
