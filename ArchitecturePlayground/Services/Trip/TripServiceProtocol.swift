//
//  TripServiceProtocol.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

protocol TripServiceProtocol {
    func fetchTripInfo(city: String, baseCurrency: String, targetCurrency: String, startDate: Date, endDate: Date) async throws -> TripInfo
    func saveTripsToDisk(trips: [TripInfo]) throws
    func restoreTripsFromDisk() throws -> [TripInfo]
}
