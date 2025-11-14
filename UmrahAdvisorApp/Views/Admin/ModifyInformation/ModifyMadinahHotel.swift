//
//  ModifyMadinahHotel.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 11/03/2025.
//

import SwiftUI

struct ModifyMadinahHotel: View {
    
    @StateObject private var viewModel = CustomPackageViewModel()
    @State private var showDeleteAlert = false
    @State private var hotelToDelete: Hotel?
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(viewModel.madinahHotels, id: \.id) { hotel in
                    NavigationLink {
                        MadinahHotelDetailView(hotel: hotel, viewModel: viewModel)
                    } label: {
                        Text(hotel.name)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        hotelToDelete = viewModel.madinahHotels[index]
                        showDeleteAlert = true
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Madinah Hotels")
            .alert("Delete Madinah Hotel", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let hotel = hotelToDelete {
                        viewModel.deleteMadinahHotel(hotel)
                    }
                }
                Button("Cancel", role: .cancel) {
                    hotelToDelete = nil
                }
            } message: {
                Text("Are you sure you want to delete this hotel?")
            }
        }
    }
}

#Preview {
    ModifyMadinahHotel()
}
