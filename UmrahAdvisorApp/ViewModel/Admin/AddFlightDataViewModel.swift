//
//  SendFlightDataViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 14/11/2025.
//

import Foundation
import Firebase

class AddFlightDataViewModel: ObservableObject {
    
    @Published var flightName: String = ""
    @Published var flightDuration: Int = 7
    @Published var flightPrice: String = ""
    @Published var durations: [FlightDuration] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    let flightDurations = [7, 14, 21, 28]
    
    func saveFlightToFirebase() {
        guard !flightName.isEmpty else {
            alertMessage = "Please enter a flight name."
            showAlert = true
            return
        }
        guard !durations.isEmpty else {
            alertMessage = "Please add at least one duration."
            showAlert = true
            return
        }
        let db = Firestore.firestore()
        let flightData: [String: Any] = [
            "name": flightName,
            "durations": durations.map { ["days": $0.days, "price": $0.price] }
        ]
        db.collection("Flights").addDocument(data: flightData) { error in
            if let error = error {
                self.alertMessage = "Error saving data: \(error.localizedDescription)"
                self.showAlert = true
            } else {
                self.alertMessage = "Flight data saved successfully!"
                self.showAlert = true
                self.flightName = ""
                self.durations = []
            }
        }
    }
    
}
