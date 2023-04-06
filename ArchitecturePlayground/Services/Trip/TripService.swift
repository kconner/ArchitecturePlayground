//
//  TripService.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

class TripService: TripServiceProtocol {
    
    private let weatherService: WeatherService
    private let currencyService: CurrencyService
    private let tripsFilename: String
    
    init(weatherService: WeatherService, currencyService: CurrencyService, tripsFilename: String = "trips.json") {
        self.weatherService = weatherService
        self.currencyService = currencyService
        self.tripsFilename = tripsFilename
    }
    
    func fetchTripInfo(city: String, baseCurrency: String, targetCurrency: String, startDate: Date, endDate: Date) async throws -> TripInfo {
        let weatherData = try await weatherService.fetchWeatherData(city: city)
        let exchangeRate = try await currencyService.fetchExchangeRate(baseCurrency: baseCurrency, targetCurrency: targetCurrency)
        
        return TripInfo(
            id: UUID(),
            city: weatherData.name,
            temperature: weatherData.main.temp,
            weatherDescription: weatherData.weather.first?.description ?? "N/A",
            baseCurrency: baseCurrency,
            targetCurrency: targetCurrency,
            exchangeRate: exchangeRate,
            startDate: startDate,
            endDate: endDate,
            isFavorite: false
        )
    }

    func saveTripsToDisk(trips: [TripInfo]) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(trips)
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw TripError.documentsDirectoryNotFound
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(tripsFilename)
        try data.write(to: fileURL)
    }
    
    func restoreTripsFromDisk() throws -> [TripInfo] {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw TripError.documentsDirectoryNotFound
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(tripsFilename)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let trips = try decoder.decode([TripInfo].self, from: data)
            return trips
        } catch {
            if let nsError = error as NSError?, nsError.domain == NSCocoaErrorDomain, nsError.code == NSFileReadNoSuchFileError {
                return []
            } else {
                throw error
            }
        }
    }
    
}
