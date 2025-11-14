//
//  ModifyFlightData.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 11/03/2025.
//

import SwiftUI

struct ModifyFlightData: View {
    
    @StateObject private var viewModel = CustomPackageViewModel()
    @State private var showDeleteAlert = false
    @State private var flightToDelete: Flight?
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(viewModel.flights, id: \.id) { flight in
                    NavigationLink {
                        FlightDetailView(flight: flight, viewModel: viewModel)
                    } label: {
                        Text(flight.name)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        flightToDelete = viewModel.flights[index]
                        showDeleteAlert = true
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Flights")
            .alert("Delete Flight", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let flight = flightToDelete {
                        viewModel.deleteFlight(flight)
                    }
                }
                Button("Cancel", role: .cancel) {
                    flightToDelete = nil
                }
            } message: {
                Text("Are you sure you want to delete this flight?")
            }
        }
    }
}

#Preview {
    ModifyFlightData()
}
