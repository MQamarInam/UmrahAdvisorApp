//
//  ZiyaratDetailView.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 15/03/2025.
//

import SwiftUI

struct ZiyaratDetailView: View {
    
    let ziyarat: Ziyarat
    @ObservedObject var viewModel: CustomPackageViewModel
    
    @State private var showEditAlert = false
    @State private var newPrice: String = ""
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Ziyarat Details:")
                    .font(.headline)
                    .padding(.top)
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(ziyarat.name)
                        Spacer()
                    }
                    HStack {
                        Text("Price")
                        Spacer()
                        Text("Rs.\(ziyarat.price, specifier: "%.1f")")
                        Spacer()
                        Button {
                            newPrice = "\(ziyarat.price)"
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
            .navigationTitle(ziyarat.name)
            .alert("Edit Price", isPresented: $showEditAlert) {
                TextField("New Price", text: $newPrice)
                    .keyboardType(.decimalPad)
                Button("Save") {
                    if let newPriceValue = Double(newPrice), let ziyaratId = ziyarat.id {
                        viewModel.updateZiyaratPrice(ziyaratId: ziyaratId, newPrice: newPriceValue)
                    }
                }
                Button("Cancel", role: .cancel) {
                    newPrice = ""
                }
            } message: {
                Text("Enter the new price for \(ziyarat.name).")
            }
        }
    }
}

#Preview {
    let viewModel = CustomPackageViewModel()
    return ZiyaratDetailView(
        ziyarat: Ziyarat(
            id: "1",
            name: "Masjid al-Haram",
            price: 500.0
        ),
        viewModel: viewModel
    )
}
