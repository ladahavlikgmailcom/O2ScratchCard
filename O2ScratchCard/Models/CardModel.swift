//
//  CardModel.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import Foundation
import Observation

@Observable
final class CardModel {
    // MARK: - singleton
    static let shared: CardModel = CardModel()

    // MARK: - initializer

    private init() { }

    // MARK: - model
    var code: UUID = UUID()
    var isScratched: Bool = false
    var isActivated: Bool = false
    var showAlert: Bool = false
}
