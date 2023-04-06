//
//  WeatherService.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

class WeatherService {
    
    private let apiKey: String
    private let baseURL: String
    
    init(apiKey: String, baseURL: String = "https://api.openweathermap.org/data/2.5/weather") {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
    
    private func buildRequestURL(city: String) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        return components?.url
    }
    
    func fetchWeatherData(city: String) async throws -> WeatherData {
        guard let url = buildRequestURL(city: city) else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw WeatherError.invalidResponse
        }
        
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        return weatherData
    }
    
}
