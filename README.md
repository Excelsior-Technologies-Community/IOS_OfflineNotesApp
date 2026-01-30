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

## 🔧 Installation

### Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.9+
- **Firebase Account** (for cloud sync)
- **GoogleService-Info.plist** (required)

### Setup

#### Step 1: Clone the Repository

```bash
https://github.com/Excelsior-Technologies-Community/IOS_OfflineNotesApp
cd offline-notes-app
```

#### Step 2: Set Up Firebase & Get GoogleService-Info.plist

This project requires Firebase for cloud synchronization. Follow these steps:

##### 2.1 Create Firebase Account

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Sign in with Google"**
3. Use your Google account or create a new one

##### 2.2 Create a New Firebase Project

1. Click **"Add project"** or **"Create a project"**
2. Enter project name (e.g., `SyncNotesApp`)
3. Click **"Continue"**
4. **Disable Google Analytics** (optional, not needed for this app)
5. Click **"Create project"**
6. Wait for project creation (takes 30-60 seconds)
7. Click **"Continue"** when ready

##### 2.3 Add iOS App to Firebase

1. In your Firebase project dashboard, click the **iOS icon** (⊕ Add app → iOS)
2. Fill in the required fields:
   
   **iOS bundle ID:** `com.yourname.SyncNotes`
   
   ⚠️ **Important:** Get your bundle ID from Xcode:
   - Open your project in Xcode
   - Select the project in navigator
   - Go to **"Signing & Capabilities"** tab
   - Copy the **Bundle Identifier**
   
   **App nickname (optional):** `SyncNotes`
   
   **App Store ID (optional):** Leave blank

3. Click **"Register app"**

##### 2.4 Download GoogleService-Info.plist

1. After registering, Firebase will show **"Download GoogleService-Info.plist"**
2. Click **"Download GoogleService-Info.plist"**
3. The file will download to your computer

##### 2.5 Add GoogleService-Info.plist to Xcode

**Critical Step - Don't Skip!**

1. Open your Xcode project
2. In the Project Navigator (left sidebar), find the **SyncNotes folder** (with blue icon)
3. **Drag and drop** the `GoogleService-Info.plist` file into this folder
4. In the dialog that appears:
   - ✅ Check **"Copy items if needed"**
   - ✅ Check **"Add to targets: SyncNotes"**
   - Click **"Finish"**

5. **Verify Installation:**
   - The file should now appear in your project navigator
   - Build the project (`Cmd + B`) - it should succeed

##### 2.6 Enable Firebase Services (Optional for Future)

In Firebase Console:

1. **Firestore Database** (for cloud storage):
   - Go to **"Build" → "Firestore Database"**
   - Click **"Create database"**
   - Select **"Start in test mode"**
   - Choose nearest location
   - Click **"Enable"**

2. **Authentication** (for user login - future feature):
   - Go to **"Build" → "Authentication"**
   - Click **"Get started"**
   - Enable **"Email/Password"** or **"Anonymous"**

#### Step 3: Install Firebase SDK

The project uses **Swift Package Manager** for Firebase:

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://github.com/firebase/firebase-ios-sdk
   ```
3. Click **"Add Package"**
4. Select these products:
   - ✅ `FirebaseCore`
   - ✅ `FirebaseFirestore` (for future cloud sync)
   - ✅ `FirebaseAuth` (for future authentication)
5. Click **"Add Package"**

#### Step 4: Build and Run

1. Select your target device or simulator
2. Press `Cmd + R` to build and run
3. If you see **"Firebase configured successfully"** in console, you're good to go! 🎉

---

### 🚨 Troubleshooting

#### Error: "GoogleService-Info.plist not found"

**Solution:**
- Make sure you added the file to the correct target
- Clean build folder: `Cmd + Shift + K`
- Rebuild: `Cmd + B`

#### Error: "No bundle identifier found"

**Solution:**
- Check that your bundle ID in Xcode matches Firebase
- Go to **Signing & Capabilities** and verify Bundle Identifier

#### Error: "Module 'Firebase' not found"

**Solution:**
- Go to **File → Add Package Dependencies**
- Re-add the Firebase package
- Make sure `FirebaseCore` is selected in target

---

### 📋 Quick Setup Checklist

Before running the app, make sure you have:

- [ ] Created Firebase account
- [ ] Created Firebase project
- [ ] Added iOS app to Firebase project
- [ ] Downloaded `GoogleService-Info.plist`
- [ ] Added `GoogleService-Info.plist` to Xcode project
- [ ] Installed Firebase SDK via Swift Package Manager
- [ ] Bundle ID matches between Xcode and Firebase
- [ ] Project builds successfully (`Cmd + B`)

---

## 🔥 Firebase Setup Guide (Detailed)

### Why Firebase?

This app uses **Firebase** as the backend for:
- ☁️ **Cloud storage** for syncing notes across devices
- 🔐 **Authentication** for user accounts (future feature)
- 📊 **Real-time sync** capabilities

### Visual Setup Guide

#### 1️⃣ Firebase Console Overview

```
┌─────────────────────────────────────────────────────────┐
│  Firebase Console (console.firebase.google.com)         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   [+ Add project]  [Project 1]  [Project 2]            │
│                                                         │
│   Your Projects:                                        │
│   ┌──────────────────────┐                             │
│   │   SyncNotesApp       │  ← Your new project         │
│   │   iOS • Android      │                             │
│   │   Created today      │                             │
│   └──────────────────────┘                             │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

#### 2️⃣ Project Dashboard

After creating your project:

```
┌─────────────────────────────────────────────────────────┐
│  Project: SyncNotesApp                                  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Get started by adding Firebase to your app            │
│                                                         │
│  [iOS]  [Android]  [Web]  [Unity]  [Flutter]          │
│    ↑                                                    │
│  Click here!                                            │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

#### 3️⃣ Register iOS App Form

```
┌─────────────────────────────────────────────────────────┐
│  Add Firebase to your iOS app                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  iOS bundle ID *                                        │
│  ┌───────────────────────────────────────────┐         │
│  │ com.yourname.SyncNotes                    │         │
│  └───────────────────────────────────────────┘         │
│                                                         │
│  App nickname (optional)                                │
│  ┌───────────────────────────────────────────┐         │
│  │ SyncNotes                                 │         │
│  └───────────────────────────────────────────┘         │
│                                                         │
│  App Store ID (optional)                                │
│  ┌───────────────────────────────────────────┐         │
│  │                                           │         │
│  └───────────────────────────────────────────┘         │
│                                                         │
│                           [Register app]                │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

#### 4️⃣ Download Configuration File

```
┌─────────────────────────────────────────────────────────┐
│  Download GoogleService-Info.plist                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Download config file and add it to your Xcode project │
│                                                         │
│  ┌────────────────────────────────────┐                │
│  │  📄 GoogleService-Info.plist       │                │
│  │  2 KB • Configuration file         │                │
│  └────────────────────────────────────┘                │
│                                                         │
│  [Download GoogleService-Info.plist]                    │
│                                                         │
│  ⚠️  Keep this file private and never commit to Git!   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

#### 5️⃣ Xcode File Structure (After Adding File)

```
SyncNotes
├── 📁 SyncNotes
│   ├── 🔵 SyncNotesApp.swift
│   ├── 📄 GoogleService-Info.plist  ← Should be here!
│   ├── 📁 Models
│   ├── 📁 Services
│   ├── 📁 ViewModels
│   └── 📁 Views
├── 📁 Products
└── 📁 Frameworks
```

### Step-by-Step Screenshots Reference

Since I can't include actual screenshots in markdown, here's where to look for each step:

| Step | What to Look For | Where on Screen |
|------|------------------|-----------------|
| **1. Create Project** | "Add project" button | Top-left of Firebase Console |
| **2. Add iOS App** | iOS icon (looks like 📱) | Center of project page |
| **3. Bundle ID** | Text field labeled "iOS bundle ID" | Registration form |
| **4. Download File** | Blue download button | After registering app |
| **5. Add to Xcode** | Drag-drop target area | Left sidebar in Xcode |

### Common Firebase Console Navigation

```
Firebase Console
│
├── 🏠 Project Overview
│   └── Add iOS app (starts here)
│
├── 🔨 Build
│   ├── Authentication (for user login)
│   ├── Firestore Database (for cloud storage)
│   ├── Realtime Database
│   └── Storage (for images/files)
│
├── 📊 Analytics (optional)
│
└── ⚙️ Project Settings
    └── Your apps (shows registered apps)
```

### Finding Your Bundle ID in Xcode

**Method 1: Quick Method**
1. Open project in Xcode
2. Click on **blue project icon** (top of navigator)
3. Select **SyncNotes** under TARGETS
4. Go to **"Signing & Capabilities"** tab
5. Look for **"Bundle Identifier"** field

**Method 2: General Tab**
1. Select project → Target
2. Go to **"General"** tab
3. Find **"Identity"** section
4. Bundle Identifier is listed there

```
┌─────────────────────────────────────────────┐
│  Identity                                   │
├─────────────────────────────────────────────┤
│  Display Name:  SyncNotes                   │
│  Bundle Identifier:  com.yourname.SyncNotes │  ← Copy this!
│  Version:  1.0                              │
│  Build:  1                                  │
└─────────────────────────────────────────────┘
```

### 🔒 Security Best Practices

#### What to Do

✅ Add `GoogleService-Info.plist` to `.gitignore`  
✅ Keep the file only in your local Xcode project  
✅ Use environment-specific config files for production

#### What NOT to Do

❌ Never commit `GoogleService-Info.plist` to public GitHub  
❌ Never share screenshots containing your file  
❌ Never hardcode Firebase API keys in source code

#### Add to .gitignore

Create or update `.gitignore` in your project root:

```gitignore
# Firebase
GoogleService-Info.plist

# Xcode
*.xcuserstate
*.xcworkspace
xcuserdata/
DerivedData/
.DS_Store

# macOS
.DS_Store

# Build
build/
*.ipa
*.dSYM.zip
*.dSYM
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
 
