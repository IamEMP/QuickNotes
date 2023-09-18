//
//  ContentView.swift
//  QuickNotes
//
//  Created by Ethan Phillips on 9/17/23.
//

import SwiftUI
import KeychainAccess

extension Date: RawRepresentable {
    public var rawValue: Int {
        Int(self.timeIntervalSinceReferenceDate)
    }
    
    public init?(rawValue: Int) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue))
    }
}

struct ContentView: View {
    @State private var notes = ""
    @State private var saveTask: Task<Void, Error>?
    @AppStorage("lastSaved") private var lastSaved = Date.now
    @AppStorage("fontSize") var fontSize = 14.0
    @StateObject var viewModel = FontSizes()
    @State var sizeAdjust = 0.0
    
    let keychain = Keychain(service: "com.ethanphillips.QuickNotes")
    var body: some View {
        VStack {
            TextEditor(text: $notes)
                .frame(width: 400 + (sizeAdjust * 100), height: 400 + (sizeAdjust * 100))
                .font(.system(size: fontSize))
            
            HStack {
                ControlGroup {
                    Menu("Font Size") {
                        Button("14", action: viewModel.fontSize14)
                        Button("20", action: viewModel.fontSize20)
                        Button("25", action: viewModel.fontSize25)
                        Button("30", action: viewModel.fontSize30)
                        Button("35", action: viewModel.fontSize35)
                        Button("40", action: viewModel.fontSize40)
                        Button("45", action: viewModel.fontSize45)
                        Button("50", action: viewModel.fontSize50)
                        Button("55", action: viewModel.fontSize55)
                        Button("60", action: viewModel.fontSize60)
                    }
                }
                ControlGroup {
                    Button {
                        sizeAdjust += 1
                    } label: {
                        Label("Contract Window", systemImage: "rectangle.expand.vertical")
                    }
                    Button {
                        sizeAdjust -= 1
                    } label: {
                        Label("Expand Window", systemImage: "rectangle.compress.vertical")
                    }
                }
                
                ControlGroup {
                    Button {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(notes, forType: .string)
                    } label: {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                    
                    Button {
                        NSApp.terminate(nil)
                    } label: {
                        Label("Quit", systemImage: "power")
                    }
                }
            }
            Text("Last Saved: \(lastSaved.formatted(date: .abbreviated, time: .shortened))")
                .foregroundStyle(.secondary)
        }
        .padding()
        .onAppear(perform: load)
        .onChange(of: notes, perform: save)
    }
    func load() {
        notes = keychain["notes"] ?? ""
    }
    func save(newValue: String) {
        saveTask?.cancel()
        
        saveTask = Task {
            try await Task.sleep(for: .seconds(3))
            keychain["notes"] = newValue
            lastSaved = .now
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
