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

    func scratch() {
        scratching = true
        scratchTask?.cancel()
        scratchTask = Task { [weak self] in
            await self?.scratchIt()
        }
    }

    var scratchTask: Task<Void, Never>? // variable for cancelling it

    func scratchIt() async {
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
        } catch { // if cancelled
            await MainActor.run { [weak self] in
                self?.scratching = false
            }
            return
        }

        await MainActor.run { [weak self] in
            guard let self else { return }
            self.card.isScratched.toggle()
            self.scratching = false
            self.onDismiss?()
        }
    }

    func onDisappear() {
        scratchTask?.cancel()
    }
}
