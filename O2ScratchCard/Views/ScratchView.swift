//
//  ScratchView.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import SwiftUI

struct ScratchView: View {

    // MARK: - Local variables

    @Environment(\.dismiss) private var dismiss
    @State private var vm = ScratchViewModel()
    @State private var scratchTask: Task<Void, Never>? // kept for cancelling it

    // MARK: - Body part

    var body: some View {
        ZStack {
            Button {
                scratchTask?.cancel()
                scratchTask = Task {
                    if await vm.scratch() {
                        dismiss()
                    }
                }
            } label: {
                Text(vm.scratchTitle)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isScratched)
            if vm.scratching {
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.large)
            }
        }
        .navigationTitle("Scratching")
        .onDisappear {
            scratchTask?.cancel()
        }
    }
}

// MARK: - Previews

#Preview("Not scratched") {
    let _ = CardModel.shared.isScratched = false
    NavigationStack {
        ScratchView()
    }
}

#Preview("Scratched") {
    let _ = CardModel.shared.isScratched = true
    NavigationStack {
        ScratchView()
    }
}
