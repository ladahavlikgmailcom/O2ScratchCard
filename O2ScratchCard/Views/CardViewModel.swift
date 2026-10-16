//
//  CardViewModel.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import SwiftUI

@Observable
final class CardViewModel {

    // MARK: - Shared

    let card = CardModel.shared

    // MARK: - View data

    var navigationTitle: String {
        "Card"
    }

    var cardCode: String {
        card.code.uuidString
    }

    var isCode: Bool {
        !card.code.uuidString.isEmpty
    }

    var haveCodeTitle: String {
        if isCode {
            "New code"
        } else {
            "No code"
        }
    }

    var isScratched: Bool {
        card.isScratched
    }

    var scratchTitle: String {
        if card.isScratched {
            "Scratched"
        } else {
            "To scratch"
        }
    }

    var isActivated: Bool {
        card.isActivated
    }

    var activationTitle: String {
        if card.isActivated {
            "Activated"
        } else {
            "To activate"
        }
    }

    var showAlert: Binding<Bool> {
        Binding<Bool>(
            get: { self.card.showAlert },
            set: { self.card.showAlert = $0 }
        )
    }

    // MARK: - Intents

    func getCode() {
        card.code = UUID()
        card.isActivated = false
        card.isScratched = false
        card.showAlert = false
    }
}
