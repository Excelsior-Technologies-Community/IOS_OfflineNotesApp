# 📒 Offline Notes App

<div align="center">

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2015.0+-lightgrey.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

**An iOS notes app with offline-first architecture and intelligent cloud sync**

[Features](#-features) • [Architecture](#-architecture) • [Installation](#-installation) • [Usage](#-usage) • [Technical Details](#-technical-details)

</div>

---

## 🎯 Overview

**Offline Notes App** is a production-ready iOS application built with SwiftUI that demonstrates offline-first architecture. Users can create and edit notes without internet connectivity, and the app intelligently syncs data when online, automatically resolving conflicts.

### Why This Matters

- ✅ Works seamlessly offline - no internet? No problem!
- ✅ Never lose data - all changes saved locally first
- ✅ Smart conflict resolution - handles concurrent edits gracefully
- ✅ Real-world architecture - production-grade patterns

---

## ✨ Features

### Core Functionality
- 📝 **Create & Edit Notes** - Full CRUD operations work offline
- 💾 **Local Storage** - JSON-based persistence using FileManager
- 🔄 **Smart Sync** - Automatic and manual synchronization
- 🌐 **Network Detection** - Real-time internet availability monitoring
- ⚔️ **Conflict Resolution** - Last-updated-wins strategy
- 🎯 **Clean UI** - Native SwiftUI interface with sync status indicators

### Technical Features
- MVVM architecture
- Background-ready sync logic
- Atomic file operations
- Type-safe data models
- Reactive UI updates

---

## 🏗 Architecture

The app follows **MVVM (Model-View-ViewModel)** pattern with clear separation of concerns:

```
┌─────────────────────────────────────────────────────┐
│                      Views                          │
│  (NotesListView, AddEditNoteView, NoteRowView)     │
└─────────────────┬───────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────┐
│                   ViewModel                         │
│              (NotesViewModel)                       │
│  • Manages app state                                │
│  • Coordinates services                             │
│  • Handles user actions                             │
└─────────────────┬───────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────┐
│                   Services                          │
│  ┌──────────────┐ ┌──────────────┐ ┌─────────────┐ │
│  │   Local      │ │     Sync     │ │   Network   │ │
│  │   Storage    │ │   Service    │ │   Monitor   │ │
│  └──────────────┘ └──────────────┘ └─────────────┘ │
└─────────────────────────────────────────────────────┘
```

### Data Flow

```
User Action
    ↓
ViewModel Updates State
    ↓
Save Locally (mark as dirty)
    ↓
Internet Available?
    ├─ NO  → Continue Offline
    └─ YES → Sync Process
              ├─ Upload dirty notes
              ├─ Download server notes
              ├─ Resolve conflicts
              └─ Mark as synced
```

---

## 📁 Project Structure

```
SyncNotes/
├── SyncNotesApp.swift              # App entry point
│
├── Models/
│   └── Note.swift                   # Core data model
│
├── Services/
│   ├── LocalStorageService.swift    # JSON persistence
│   ├── SyncService.swift            # Sync logic
│   └── NetworkMonitor.swift         # Internet detection
│
├── ViewModels/
│   └── NotesViewModel.swift         # Business logic
│
└── Views/
    ├── NotesListView.swift          # Main list screen
    ├── AddEditNoteView.swift        # Note editor
    └── NoteRowView.swift            # List item view
```

---
 
## 🚀 Usage

### Creating Notes Offline

1. Launch the app
2. Tap the **"+"** button
3. Enter title and content
4. Tap **"Save"**
5. Note is saved locally with `isDirty = true`

### Syncing Notes

**Manual Sync:**
- Tap the **"Sync"** button in the toolbar
- App uploads dirty notes and downloads server changes

**Automatic Sync:**
- Happens automatically when internet becomes available
- Background sync (future enhancement)

### Conflict Resolution

When the same note is edited offline and on the server:

```swift
if localNote.updatedAt > serverNote.updatedAt {
    // Local version wins
    serverNote = localNote
} else {
    // Server version wins
    localNote = serverNote
}
```

**Strategy:** Last-Updated-Wins (most common in production apps)

---

## 💻 Technical Details

### Core Components

#### 1. Note Model

```swift
struct Note: Identifiable, Codable, Equatable {
    let id: UUID              // Unique identifier
    var title: String         // Note title
    var content: String       // Note content
    var updatedAt: Date       // Timestamp for conflict resolution
    var isDirty: Bool         // Tracks unsaved changes
}
```

**Why these fields?**
- `id` - Ensures uniqueness across devices
- `updatedAt` - Critical for conflict resolution
- `isDirty` - Marks notes that need syncing

#### 2. Local Storage

Uses **FileManager** to persist notes as JSON:

```swift
// Save location
Documents/notes.json
```

**Advantages:**
- No database overhead
- Easy debugging
- Human-readable format
- Perfect for < 1000 notes

#### 3. Network Monitoring

Real-time internet detection using `NWPathMonitor`:

```swift
monitor.pathUpdateHandler = { path in
    self.isConnected = path.status == .satisfied
}
```

#### 4. Sync Algorithm

```
┌─────────────────────────────────────────┐
│         SYNC PROCESS                    │
├─────────────────────────────────────────┤
│                                         │
│  1. Check network connectivity          │
│  2. Upload dirty local notes            │
│     └─> For each dirty note:            │
│         • Check if exists on server     │
│         • Compare timestamps            │
│         • Upload if newer               │
│                                         │
│  3. Download server notes               │
│     └─> For each server note:           │
│         • Check if exists locally       │
│         • Compare timestamps            │
│         • Download if newer             │
│                                         │
│  4. Mark all notes as clean             │
│  5. Save to local storage               │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🎨 UI Components

### NotesListView
- Displays all notes in a scrollable list
- Shows sync status with red indicator
- Toolbar with Sync and Add buttons

### AddEditNoteView
- TextField for title
- TextEditor for content
- Works completely offline

### NoteRowView
- Displays note preview
- Shows "Not synced" indicator for dirty notes

---

## 🔒 Data Safety Features

- ✅ **Atomic writes** - No data corruption during saves
- ✅ **Crash-safe** - Notes persist even if app terminates
- ✅ **Sync-safe** - Handles partial sync failures gracefully
- ✅ **Type-safe** - Codable protocol ensures data integrity
 
