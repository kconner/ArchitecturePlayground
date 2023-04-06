//
//  FakeWeatherService.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

class FakeWeatherService: WeatherServiceProtocol {
    private var fakeWeatherData: WeatherData

    init(fakeWeatherData: WeatherData) {
        self.fakeWeatherData = fakeWeatherData
    }

    func fetchWeatherData(city: String) async throws -> WeatherData {
        return fakeWeatherData
    }
}
