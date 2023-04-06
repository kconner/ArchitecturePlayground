//
//  TripInfo.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

struct TripInfo: Codable {
    
    let id: UUID
    let city: String
    let temperature: Double
    let weatherDescription: String
    let baseCurrency: String
    let targetCurrency: String
    let exchangeRate: Double
    let startDate: Date
    let endDate: Date
    var isFavorite: Bool
    
}
