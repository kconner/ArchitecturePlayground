//
//  AddTripView.swift
//  ArchitecturePlayground
//
//  Created by Kevin Conner on 2023-04-05.
//

import SwiftUI

struct AddTripView: View {
    
    @EnvironmentObject var tripState: TripState
    @Environment(\.presentationMode) var presentationMode

    @State private var city: String
    @State private var baseCurrency: String
    @State private var targetCurrency: String
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    init(city: String = "", baseCurrency: String = "", targetCurrency: String = "") {
        _city = State(initialValue: city)
        _baseCurrency = State(initialValue: baseCurrency)
        _targetCurrency = State(initialValue: targetCurrency)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("City", text: $city)
                    TextField("Base Currency", text: $baseCurrency)
                    TextField("Target Currency", text: $targetCurrency)
                }
                Section {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                    DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                }
            }
            .navigationTitle("Add Trip")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await tripState.addTrip(city: city, baseCurrency: baseCurrency, targetCurrency: targetCurrency, startDate: startDate, endDate: endDate)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(city.isEmpty)
                }
            }
        }
    }

}

struct AddTripView_Previews: PreviewProvider {
    static var previews: some View {
        let testData: [TripInfo] = []
        let fakeTripService = FakeTripService(testData: testData)
        let tripState = TripState(tripService: fakeTripService)
        
        let sampleCity = "San Francisco"
        let sampleBaseCurrency = "USD"
        let sampleTargetCurrency = "EUR"
        
        AddTripView()
            .environmentObject(tripState)
            .previewDisplayName("Empty")
        
        AddTripView(city: sampleCity, baseCurrency: sampleBaseCurrency, targetCurrency: sampleTargetCurrency)
            .environmentObject(tripState)
            .previewDisplayName("Populated")
    }
}
