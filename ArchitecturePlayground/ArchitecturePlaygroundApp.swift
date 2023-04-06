//
//  ArchitecturePlaygroundApp.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import SwiftUI

@main
struct ArchitecturePlaygroundApp: App {
    
    @StateObject private var tripState: TripState

    init() {
        let tripService: any TripServiceProtocol
        
        if ProcessInfo().arguments.contains("--fake") {
            // Fake service stack
            tripService = FakeTripService(testData: [])
        } else {
            // Real service stack
            let weatherService = WeatherService(apiKey: "<YOUR_WEATHER_API_KEY>")
            let currencyService = CurrencyService(apiKey: "<YOUR_CURRENCY_API_KEY>")
            tripService = TripService(weatherService: weatherService, currencyService: currencyService)
        }
        
        // In-memory data stores, one level above the view layer
        let tripState = TripState(tripService: tripService)
        _tripState = StateObject(wrappedValue: tripState)
    }

    var body: some Scene {
        WindowGroup {
            TripsView()
                .environmentObject(tripState)
        }
    }

}
