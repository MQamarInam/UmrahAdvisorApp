//
//  AddZiyaratDataViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 14/11/2025.
//

import Foundation
import Firebase

class AddZiyaratDataViewModel: ObservableObject {
    
    @Published var zyaratName: String = ""
    @Published var zyaratPrice: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func saveZiyaratToFirebase() {
        guard !zyaratName.isEmpty else {
            alertMessage = "Please enter a Ziyarat name."
            showAlert = true
            return
        }
        guard let price = Double(zyaratPrice) else {
            alertMessage = "Invalid price. Please enter a valid number."
            showAlert = true
            return
        }
        let db = Firestore.firestore()
        let ziyaratData: [String: Any] = [
            "name": zyaratName,
            "price": price
        ]
        db.collection("Ziyarats").addDocument(data: ziyaratData) { error in
            if let error = error {
                self.alertMessage = "Error saving Ziyarat data: \(error.localizedDescription)"
                self.showAlert = true
            } else {
                self.alertMessage = "Ziyarat data saved successfully!"
                self.showAlert = true
                self.zyaratName = ""
                self.zyaratPrice = ""
            }
        }
    }
    
}
