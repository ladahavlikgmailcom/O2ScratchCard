//
//  ActivationViewModel.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import SwiftUI

@Observable
final class ActivationViewModel {

    // MARK: - Shared

    let card = CardModel.shared

    // MARK: - local variables

    var activating: Bool = false

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

    var showAlert: Binding<Bool> {
        Binding<Bool>(
            get: { self.card.showAlert },
            set: { self.card.showAlert = $0 }
        )
    }

    // MARK: - intents

    /// Activates the card. Returns `true` when the request succeeded and the view can be dismissed.
    func activate() async -> Bool {
        activating = true
        defer { activating = false }

        do {
            let url = URL(string: "https://api.o2.sk/version")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let apiVersion = try JSONDecoder().decode(APIVersion.self, from: data)
            card.isActivated = apiVersion.iOSVersion > 6.1
            return true
        } catch {
            card.showAlert = true
            return false
        }
    }
}
