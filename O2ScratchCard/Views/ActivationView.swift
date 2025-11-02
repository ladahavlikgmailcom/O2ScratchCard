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
    @Bindable var vm: ActivationViewModel = .init()

    // MARK: - Body part

    var body: some View {
        ZStack {
            Button {
                vm.activate()
            } label: {
                Text(vm.activationTitle)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isActivated)
            .navigationTitle("Activation")
            .onAppear {
                vm.onDismiss = { dismiss() }
            }
            if vm.activating {
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.large)
            }
        }
        .alert("An error appear in the process. Please try again.", isPresented: vm.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - Previews

#Preview("Deactivated") {
    let _ = CardModel.shared.isActivated = false
    NavigationStack {
        ActivationView()
    }
}

#Preview("Activated") {
    let _ = CardModel.shared.isActivated = true
    NavigationStack {
        ActivationView()
    }
}
