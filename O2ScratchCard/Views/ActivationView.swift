//
//  ActivationView.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import SwiftUI

struct ActivationView: View {

    // MARK: - Local variables

    @Environment(\.dismiss) private var dismiss
    @State private var vm = ActivationViewModel()

    // MARK: - Body part

    var body: some View {
        ZStack {
            Button {
                Task {
                    if await vm.activate() {
                        dismiss()
                    }
                }
            } label: {
                Text(vm.activationTitle)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isActivated)
            if vm.activating {
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.large)
            }
        }
        .navigationTitle("Activation")
        .alert("An error appear in the process. Please try again.", isPresented: vm.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - Previews

#Preview("Deactivated") {
    let _ = CardModel.shared.isActivated = false
    let _ = CardModel.shared.showAlert = false
    NavigationStack {
        ActivationView()
    }
}

#Preview("Activated") {
    let _ = CardModel.shared.isActivated = true
    let _ = CardModel.shared.showAlert = false
    NavigationStack {
        ActivationView()
    }
}

#Preview("Alert") {
    let _ = CardModel.shared.isActivated = false
    let _ = CardModel.shared.showAlert = true
    NavigationStack {
        ActivationView()
    }
}
