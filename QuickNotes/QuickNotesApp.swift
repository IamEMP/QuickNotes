//
//  QuickNotesApp.swift
//  QuickNotes
//
//  Created by Ethan Phillips on 9/17/23.
//

import SwiftUI

@main
struct QuickNotesApp: App {
    var body: some Scene {
        
        MenuBarExtra("Notes") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
    }
}
