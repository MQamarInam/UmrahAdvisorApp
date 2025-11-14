//
//  AddMakkahHotelViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 14/11/2025.
//

import Foundation
import Firebase

class AddMakkahHotelDataViewModel: ObservableObject {
    
    @Published var hotelName: String = ""
    @Published var roomType: String = "Single Bed"
    @Published var roomPrice: String = ""
    @Published var rooms: [Room] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    let roomTypes = ["Single Bed", "Double Bed", "Quad Bed", "Shared"]
    
    func saveHotelToFirebase() {
        guard !hotelName.isEmpty else {
            alertMessage = "Please enter a hotel name."
            showAlert = true
            return
        }
        guard !rooms.isEmpty else {
            alertMessage = "Please add at least one room."
            showAlert = true
            return
        }
        let db = Firestore.firestore()
        let hotelData: [String: Any] = [
            "name": hotelName,
            "rooms": rooms.map { ["type": $0.type, "price": $0.price] }
        ]
        db.collection("MakkahHotels").addDocument(data: hotelData) { error in
            if let error = error {
                self.alertMessage = "Error saving data: \(error.localizedDescription)"
                self.showAlert = true
            } else {
                self.alertMessage = "Hotel data saved successfully!"
                self.showAlert = true
                self.hotelName = ""
                self.rooms = []
            }
        }
    }
    
}
