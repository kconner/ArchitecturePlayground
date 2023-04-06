//
//  CurrencyServiceProtocol.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

protocol CurrencyServiceProtocol {
    func fetchExchangeRate(baseCurrency: String, targetCurrency: String) async throws -> Double
}
