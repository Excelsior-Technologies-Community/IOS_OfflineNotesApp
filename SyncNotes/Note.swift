//
//  Note.swift
//  SyncNotes
//
//  Created by Noman belim on 30/01/26.
//

import Foundation
import Foundation

struct Note: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var updatedAt: Date
    var isDirty: Bool
}
