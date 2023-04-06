//
//  FakeTripService.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

class FakeTripService: TripServiceProtocol {
    
    private var testData: [TripInfo]

    init(testData: [TripInfo]) {
        self.testData = testData
    }

    func fetchTripInfo(city: String, baseCurrency: String, targetCurrency: String, startDate: Date, endDate: Date) async throws -> TripInfo {
        return TripInfo(
            id: UUID(),
            city: city,
            temperature: 25.0,
            weatherDescription: "Clear sky",
            baseCurrency: baseCurrency,
            targetCurrency: targetCurrency,
            exchangeRate: 1.0,
            startDate: startDate,
            endDate: endDate,
            isFavorite: false
        )
    }
    
    func saveTripsToDisk(trips: [TripInfo]) throws {
        // You can either save the trips to a temporary file on disk for testing purposes
        // or update the testData variable directly as per your testing requirements
        testData = trips
    }

    func restoreTripsFromDisk() throws -> [TripInfo] {
        // You can either read the trips from the temporary file on disk
        // or return the testData variable directly as per your testing requirements
        return testData
    }
    
}
