//
//  SaveTransportationDataViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 14/11/2025.
//

import Foundation
import Firebase

class AddTransportationDataViewModel: ObservableObject {
    
    @Published var transportationType: String = "Shared"
    @Published var transportationPrice: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    let transportations = ["Shared", "Private"]
    
    func saveTransportationToFirebase() {
        guard !transportationType.isEmpty else {
            alertMessage = "Please select a transportation type."
            showAlert = true
            return
        }
        guard let price = Double(transportationPrice) else {
            alertMessage = "Invalid price. Please enter a valid number."
            showAlert = true
            return
        }
        let db = Firestore.firestore()
        let transportationData: [String: Any] = [
            "type": transportationType,
            "price": price
        ]
        db.collection("Transportations").addDocument(data: transportationData) { error in
            if let error = error {
                self.alertMessage = "Error saving Transportation data: \(error.localizedDescription)"
                self.showAlert = true
            } else {
                self.alertMessage = "Transportation data saved successfully!"
                self.showAlert = true
                self.transportationType = "Shared"
                self.transportationPrice = ""
            }
        }
    }
    
}
