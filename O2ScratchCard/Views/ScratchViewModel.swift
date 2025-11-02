//
//  ScratchViewModel.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import SwiftUI

@Observable
class ScratchViewModel {

    // MARK: - Shared

    let card = CardModel.shared

    // MARK: - Routing

    var onDismiss: (() -> Void)?

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

    func scratch() {
        card.isScratched.toggle()
        onDismiss?()
    }
}
