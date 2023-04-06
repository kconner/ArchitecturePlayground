//
//  ExchangeData.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

struct ExchangeData: Codable {
    let base: String
    let rates: [String: Double]
}
