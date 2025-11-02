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
    let vm: ScratchViewModel = .init()

    // MARK: - Body part

    var body: some View {
        ZStack {
            Button {
                vm.scratch()
            } label: {
                Text(vm.scratchTitle)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isScratched)
            .navigationTitle("Scratching")
            .onAppear {
                vm.onDismiss = { dismiss() }
            }
            .onDisappear {
                vm.onDisappear()
            }
            if vm.scratching {
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.large)
            }
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
