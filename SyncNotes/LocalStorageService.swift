//
//  LocalStorageService.swift
//  SyncNotes
//
//  Created by Noman belim on 30/01/26.
//

import Foundation
import Foundation

class LocalStorageService {
    static let shared = LocalStorageService()
    private init() {}

    private let fileName = "notes.json"

    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }

    func loadNotes() -> [Note] {
        guard let data = try? Data(contentsOf: fileURL) else {
            return []
        }
        return (try? JSONDecoder().decode([Note].self, from: data)) ?? []
    }

    func saveNotes(_ notes: [Note]) {
        guard let data = try? JSONEncoder().encode(notes) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}
