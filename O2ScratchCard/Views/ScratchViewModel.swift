//
//  ScratchViewModel.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import SwiftUI

@Observable
final class ScratchViewModel {

    // MARK: - Shared

    let card = CardModel.shared

    // MARK: - local variables

    var scratching: Bool = false

    // MARK: - View data

    var scratchTitle: String {
        if card.isScratched {
            "I'm Scratched"
        } else {
            "Scratch me!"
        }
    }

    var isScratched: Bool {
        card.isScratched
    }

    // MARK: - intents

    /// Scratches the card. Returns `true` when finished, `false` when cancelled.
    func scratch() async -> Bool {
        scratching = true
        defer { scratching = false }

        do {
            try await Task.sleep(for: .seconds(2))
        } catch { // if cancelled
            return false
        }

        card.isScratched.toggle()
        return true
    }
}
