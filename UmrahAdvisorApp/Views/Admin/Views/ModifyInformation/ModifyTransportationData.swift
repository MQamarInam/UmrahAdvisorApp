//
//  ModifyTransportationData.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 11/03/2025.
//

import SwiftUI

struct ModifyTransportationData: View {
    
    @StateObject private var viewModel = CustomPackageViewModel()
    @State private var showDeleteAlert = false
    @State private var transportationToDelete: Transportation?
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(viewModel.transportations, id: \.id) { transportation in
                    NavigationLink {
                        TransportationDetailView(transportation: transportation, viewModel: viewModel)
                    } label: {
                        Text(transportation.type)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        transportationToDelete = viewModel.transportations[index]
                        showDeleteAlert = true
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Transportations")
            .alert("Delete Transportation", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let transportation = transportationToDelete {
                        viewModel.deleteTransportation(transportation)
                    }
                }
                Button("Cancel", role: .cancel) {
                    transportationToDelete = nil
                }
            } message: {
                Text("Are you sure you want to delete this Transportation?")
            }
        }
        
    }
}

#Preview {
    ModifyTransportationData()
}
