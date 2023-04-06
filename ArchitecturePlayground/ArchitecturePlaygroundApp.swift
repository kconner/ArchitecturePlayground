//
//  ArchitecturePlaygroundApp.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import SwiftUI

@main
struct ArchitecturePlaygroundApp: App {
    
    // States are ObservableObjects.
    // They hold data in memory for views.
    // They expose meaningful behaviors by abstracting over services.
    // In this app we have just one.
    @StateObject private var tripState: TripState

    init() {
        let tripService: any TripServiceProtocol
        
        if ProcessInfo().arguments.contains("--fake") {
            // Fake service stack:
            // Only services needed by States are necessary to create in this case.
            // Pass this launch argument from UI tests or to debug with the same setup.
            tripService = FakeTripService(testData: [])
        } else {
            // Real service stack:
            // Services are a directed acyclic graph.
            // They consume one another by protocol existential.
            // Unit tests can supply fakes to test a service in isolation.
            // Services do async things and don't hold any state of their own.
            let weatherService = WeatherService(apiKey: "<YOUR_WEATHER_API_KEY>")
            let currencyService = CurrencyService(apiKey: "<YOUR_CURRENCY_API_KEY>")
            tripService = TripService(weatherService: weatherService, currencyService: currencyService)
        }
        
        // States also consume services by protocol.
        // States can be created with fake services in preview providers.
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
