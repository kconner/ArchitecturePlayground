//
//  CurrencyService.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

/// Abstracts an exchange rate API.
class CurrencyService: CurrencyServiceProtocol {
    
    private let apiKey: String
    private let baseURL: String
    
    init(apiKey: String, baseURL: String = "https://api.exchangeratesapi.io/v1/latest") {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
    
    private func buildRequestURL(baseCurrency: String, targetCurrency: String) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "access_key", value: apiKey),
            URLQueryItem(name: "base", value: baseCurrency),
            URLQueryItem(name: "symbols", value: targetCurrency)
        ]
        return components?.url
    }
    
    func fetchExchangeRate(baseCurrency: String, targetCurrency: String) async throws -> Double {
        guard let url = buildRequestURL(baseCurrency: baseCurrency, targetCurrency: targetCurrency) else {
            throw CurrencyError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw CurrencyError.invalidResponse
        }
        
        let exchangeData = try JSONDecoder().decode(ExchangeData.self, from: data)
        guard let rate = exchangeData.rates[targetCurrency] else {
            throw CurrencyError.rateNotFound
        }
        
        return rate
    }
    
}
