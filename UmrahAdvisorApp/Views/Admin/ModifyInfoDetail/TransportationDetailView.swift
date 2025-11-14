//
//  TransportationDetailView.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 15/03/2025.
//

import SwiftUI

struct TransportationDetailView: View {
    
    let transportation: Transportation
    @ObservedObject var viewModel: CustomPackageViewModel
    
    @State private var showEditAlert = false
    @State private var newPrice: String = ""
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Transportation Details:")
                    .font(.headline)
                    .padding(.top)
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Type")
                        Spacer()
                        Text(transportation.type)
                        Spacer()
                    }
                    HStack {
                        Text("Price")
                        Spacer()
                        Text("Rs.\(transportation.price, specifier: "%.1f")")
                        Spacer()
                        Button {
                            newPrice = "\(transportation.price)"
                            showEditAlert = true
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .padding(.trailing, 10)
                                .foregroundStyle(Color.blue)
                                .font(.headline)
                        }
                    }
                }
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.bgcu.opacity(0.6))
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle(transportation.type)
            .alert("Edit Price", isPresented: $showEditAlert) {
                TextField("New Price", text: $newPrice)
                    .keyboardType(.decimalPad)
                Button("Save") {
                    if let newPriceValue = Double(newPrice) {
                        let transportationId = transportation.id   // already non-optional
                        viewModel.updateTransportationPrice(transportationId: transportationId, newPrice: newPriceValue)
                    }
                }
                Button("Cancel", role: .cancel) {
                    newPrice = ""
                }
            } message: {
                Text("Enter the new price for \(transportation.type).")
            }
        }
    }
}

#Preview {
    let viewModel = CustomPackageViewModel()
    return TransportationDetailView(
        transportation: Transportation(
            id: "1",
            type: "Bus",
            price: 200.0
        ),
        viewModel: viewModel
    )
}
