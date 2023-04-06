//
//  WeatherData.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]

    struct Main: Codable {
        let temp: Double
    }

    struct Weather: Codable {
        let description: String
    }
    
}
