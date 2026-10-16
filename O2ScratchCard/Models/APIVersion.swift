//
//  APIVersion.swift
//  O2ScratchCard
//
//  Created by [ laďa ] HAVLÍK on 02.11.2025.
//  Copyright © 2025 ladahavlik.eu. All rights reserved.
//

import Foundation

nonisolated struct APIVersion: Decodable, Sendable {
    let ios: String

    var iOSVersion: Double {
        Double(ios) ?? 0
    }
}
