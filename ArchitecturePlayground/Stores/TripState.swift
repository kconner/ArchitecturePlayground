//
//  TripState.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import Foundation

/// Stores trips in memory for views to consume.
class TripState: ObservableObject {
    
    private let tripService: any TripServiceProtocol
    
    @Published private(set) var trips: [TripInfo] = []

    init(tripService: any TripServiceProtocol) {
        self.tripService = tripService
        do {
            trips = try tripService.restoreTripsFromDisk()
        } catch {
            print("Error loading trips from disk: \(error)")
            trips = []
        }
    }
    
    func addTrip(city: String, baseCurrency: String, targetCurrency: String, startDate: Date, endDate: Date) async {
        do {
            let tripInfo = try await tripService.fetchTripInfo(city: city, baseCurrency: baseCurrency, targetCurrency: targetCurrency, startDate: startDate, endDate: endDate)
            DispatchQueue.main.async {
                self.trips.append(tripInfo)
                self.saveTripsToDisk()
            }
        } catch {
            print("Error fetching trip info: \(error)")
        }
    }

    func deleteTrips(at offsets: IndexSet) {
        trips.remove(atOffsets: offsets)
        saveTripsToDisk()
    }
    
    func toggleFavorite(trip: TripInfo) {
        if let index = trips.firstIndex(where: { $0.id == trip.id }) {
            trips[index].isFavorite.toggle()
            saveTripsToDisk()
        }
    }

    private func saveTripsToDisk() {
        do {
            try tripService.saveTripsToDisk(trips: trips)
        } catch {
            print("Error saving trips to disk: \(error)")
        }
    }
    
}
