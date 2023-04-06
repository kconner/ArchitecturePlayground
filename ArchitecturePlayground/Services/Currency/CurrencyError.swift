//
//  CurrencyError.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

enum CurrencyError: Error {
    case invalidURL
    case invalidResponse
    case rateNotFound
}
