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

    // MARK: - intents

    func activate() {
        activating = true
        Task { [weak self] in
            await self?.activateIt()
        }
    }

    func activateIt() async {
        let task = Task {
            let url = URL(string: "https://api.o2.sk/version")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(APIVersion.self, from: data)
        }

        do {
            let apiVersion = try await task.value
            card.isActivated = apiVersion.iOSVersion > 6.1
            activating = false
            onDismiss?()
        } catch {
            card.showAlert = true
            activating = false
        }

    }
}
