//
//  CardView.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import SwiftUI

struct CardView: View {

    // MARK: - Local Variables

    var vm: CardViewModel = .init()

    // MARK: - Body part

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                card
                codeButton
                scratchButton
                activationLink
            }
            .padding()
            .navigationTitle(vm.navigationTitle)

        }
    }

    // MARK: - body parts

    var card: some View {
        Text(vm.cardCode)
            .font(.caption2)
            .bold()
            .foregroundStyle(vm.isActivated ? Color.green : Color.gray)
            .padding(8)
            .redacted(reason: vm.isScratched ? .invalidated : .placeholder)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(vm.isActivated ? Color.green : Color.gray)
            )
    }

    var codeButton: some View {
        Button {
            vm.getCode()
        } label: {
            codeLabel
        }
    }

    var codeLabel: some View {
        HStack {
            Text(vm.haveCodeTitle)
            Image(systemName: vm.isCode ? "checkmark.circle.dotted" : "xmark.app")
        }
        .font(.headline)
    }

    var scratchButton: some View {
        NavigationLink {
            ScratchView()
        } label: {
            scratchLabel
        }
        .disabled(vm.isScratched)
    }

    var scratchLabel: some View {
        HStack {
            Text(vm.scratchTitle)
            Image(systemName: vm.isScratched ? "checkmark.circle.dotted" : "xmark.app")
        }
        .font(.headline)
    }

    var activationLink: some View {
        NavigationLink {
            ActivationView()
        } label: {
            activationLabel
        }
        .disabled(vm.isActivated || !vm.isScratched)
    }

    var activationLabel: some View {
        HStack {
            Text(vm.activationTitle)
            Image(systemName: vm.isActivated ? "checkmark.circle.dotted" : "xmark.app")
        }
        .font(.headline)
    }
}

// MARK: - Previews

#Preview {
    CardView()
}
