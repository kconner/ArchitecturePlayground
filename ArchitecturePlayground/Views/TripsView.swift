//
//  TripsView.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import SwiftUI

struct TripsView: View {
    
    @EnvironmentObject var tripState: TripState
    @State private var showAddTripModal = false

    var body: some View {
        NavigationView {
            List {
                ForEach(tripState.trips, id: \.id) { trip in
                    NavigationLink(destination: TripDetailView(trip: trip)) {
                        VStack(alignment: .leading) {
                            Text(trip.city)
                                .font(.headline)
                            Text("From: \(trip.startDate, formatter: Self.dateFormatter) To: \(trip.endDate, formatter: Self.dateFormatter)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: tripState.deleteTrips)
            }
            .navigationTitle("Trips")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddTripModal.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showAddTripModal) {
                        AddTripView()
                            .environmentObject(tripState)
                    }
                    
                    EditButton()
                }
            }
        }
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        let testData = [
            TripInfo(id: UUID(), city: "New York", temperature: 22.0, weatherDescription: "Sunny", baseCurrency: "USD", targetCurrency: "EUR", exchangeRate: 0.85, startDate: Date(), endDate: Date().addingTimeInterval(60 * 60 * 24), isFavorite: false),
            TripInfo(id: UUID(), city: "Paris", temperature: 18.0, weatherDescription: "Cloudy", baseCurrency: "EUR", targetCurrency: "USD", exchangeRate: 1.18, startDate: Date(), endDate: Date().addingTimeInterval(60 * 60 * 24), isFavorite: true)
        ]
        let fakeTripService = FakeTripService(testData: testData)
        let tripState = TripState(tripService: fakeTripService)

        return TripsView()
            .environmentObject(tripState)
    }
}
