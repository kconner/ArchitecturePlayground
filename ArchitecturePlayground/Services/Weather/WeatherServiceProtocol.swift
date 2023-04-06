//
//  WeatherServiceProtocol.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeatherData(city: String) async throws -> WeatherData
}
