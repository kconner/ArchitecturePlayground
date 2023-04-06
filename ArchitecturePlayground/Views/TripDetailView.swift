//
//  TripDetailView.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import SwiftUI

struct TripDetailView: View {
    
    @EnvironmentObject var tripState: TripState
    
    let trip: TripInfo

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Location").font(.headline)
                    Text("City: \(trip.city)")
                    Text("Temperature: \(trip.temperature, specifier: "%.1f") °C")
                    Text("Weather Description: \(trip.weatherDescription)")
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Currency").font(.headline)
                    Text("Base Currency: \(trip.baseCurrency)")
                    Text("Target Currency: \(trip.targetCurrency)")
                    Text("Exchange Rate: \(trip.exchangeRate, specifier: "%.4f")")
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Dates").font(.headline)
                    Text("Start Date: \(trip.startDate, formatter: TripDetailView.dateFormatter)")
                    Text("End Date: \(trip.endDate, formatter: TripDetailView.dateFormatter)")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Trip Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    tripState.toggleFavorite(trip: trip)
                }) {
                    Image(systemName: trip.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(trip.isFavorite ? .red : .gray)
                }
            }
        }
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTrip = TripInfo(
            id: UUID(),
            city: "New York",
            temperature: 22.0,
            weatherDescription: "Sunny",
            baseCurrency: "USD",
            targetCurrency: "EUR",
            exchangeRate: 0.85,
            startDate: Date(),
            endDate: Date().addingTimeInterval(60 * 60 * 24),
            isFavorite: false
        )

        let testData: [TripInfo] = [sampleTrip]
        let fakeTripService = FakeTripService(testData: testData)
        let tripState = TripState(tripService: fakeTripService)

        return TripDetailView(trip: sampleTrip)
            .environmentObject(tripState)
    }
}
