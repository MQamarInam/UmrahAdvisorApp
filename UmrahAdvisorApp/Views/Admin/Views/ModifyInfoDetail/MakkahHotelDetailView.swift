//
//  MakkahHotelDetailView.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 15/03/2025.
//

import SwiftUI

struct MakkahHotelDetailView: View {
    
    let hotel: Hotel
    @ObservedObject var viewModel: CustomPackageViewModel
    
    @State private var showEditAlert = false
    @State private var newPrice: String = ""
    @State private var selectedRoom: Room?
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Available Rooms:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(hotel.rooms, id: \.id) { room in
                    VStack(spacing: 10) {
                        HStack {
                            Text("Room Type")
                            Spacer()
                            Text(room.type)
                            Spacer()
                        }
                        HStack {
                            Text("Price")
                            Spacer()
                            Text("Rs.\(room.price, specifier: "%.1f")")
                            Spacer()
                            Button {
                                selectedRoom = room
                                newPrice = "\(room.price)"
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
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(hotel.name)
            .alert("Edit Price", isPresented: $showEditAlert, presenting: selectedRoom) { room in
                TextField("New Price", text: $newPrice)
                    .keyboardType(.decimalPad)
                Button("Save") {
                    if let newPriceValue = Double(newPrice), let hotelId = hotel.id, let roomId = room.id {
                        viewModel.updateMakkahHotelRoomPrice(hotelId: hotelId, roomId: roomId, newPrice: newPriceValue)
                    }
                }
                Button("Cancel", role: .cancel) {
                    selectedRoom = nil
                }
            } message: { room in
                Text("Enter the new price for \(room.type) room.")
            }
        }
    }
}

#Preview {
    let viewModel = CustomPackageViewModel()
    return MakkahHotelDetailView(
        hotel: Hotel(
            id: "1",
            name: "Makkah Royal Hotel",
            rooms: [
                Room(id: "r1", type: "Single", price: 1000.0),
                Room(id: "r2", type: "Double", price: 1500.0)
            ]
        ),
        viewModel: viewModel
    )
}
