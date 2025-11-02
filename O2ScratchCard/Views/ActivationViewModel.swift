//
//  ActivationViewModel.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import SwiftUI

@Observable
class ActivationViewModel {

    // MARK: - Shared

    let card = CardModel.shared

    // MARK: - Routing

    var onDismiss: (() -> Void)?

    // MARK: - View data

    var activationTitle: String {
        if card.isActivated {
            "I'm Activated"
        } else {
            "Activate me!"
        }
    }

    var isActivated: Bool {
        card.isActivated
    }

    // MARK: - intents

    func activate() {
        card.isActivated.toggle()
        onDismiss?()
    }
}
