//
//  FakeCurrencyService.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

class FakeCurrencyService: CurrencyServiceProtocol {
    private var fakeExchangeRate: Double

    init(fakeExchangeRate: Double) {
        self.fakeExchangeRate = fakeExchangeRate
    }

    func fetchExchangeRate(baseCurrency: String, targetCurrency: String) async throws -> Double {
        return fakeExchangeRate
    }
}
