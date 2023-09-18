//
//  FontSizes.swift
//  QuickNotes
//
//  Created by Ethan Phillips on 9/17/23.
//

import Foundation
import SwiftUI


class FontSizes: ObservableObject {
    @AppStorage("fontSize") var fontSize = 14.0
    
    
    func fontSize14() {
        fontSize = 14.0
    }
    func fontSize20() {
        fontSize = 20.0
    }
    func fontSize25() {
        fontSize = 25.0
    }
    func fontSize30() {
        fontSize = 30.0
    }
    func fontSize35() {
        fontSize = 35.0
    }
    func fontSize40() {
        fontSize = 40.0
    }
    func fontSize45() {
        fontSize = 45.0
    }
    func fontSize50() {
        fontSize = 50.0
    }
    func fontSize55() {
        fontSize = 55.0
    }
    func fontSize60() {
        fontSize = 60.0
    }
}
