//
//  PackageDataViewModel.swift
//  UmrahBooking
//
//  Created by Qaim's Macbook  on 16/04/2025.
//

import Foundation
import Firebase

class PackageCreationDataViewModel: ObservableObject {
    
    @Published var makkahHotels: [String] = []
    @Published var madinahHotels: [String] = []
    @Published var flightOptions: [String] = []
    @Published var isLoading = false
    
    private var db = Firestore.firestore()
    
    init() {
        fetchDataFromFirebase()
    }
    
    func fetchDataFromFirebase() {
        isLoading = true
        
        // Fetch Makkah Hotels (names only)
        db.collection("MakkahHotels").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching Makkah hotels: \(error.localizedDescription)")
            } else {
                self?.makkahHotels = snapshot?.documents.compactMap { $0["name"] as? String } ?? []
            }
        }
        
        // Fetch Madinah Hotels (names only)
        db.collection("MadinahHotels").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching Madinah hotels: \(error.localizedDescription)")
            } else {
                self?.madinahHotels = snapshot?.documents.compactMap { $0["name"] as? String } ?? []
            }
        }
        
        // Fetch Flights (names only)
        db.collection("Flights").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching flights: \(error.localizedDescription)")
            } else {
                self?.flightOptions = snapshot?.documents.compactMap { $0["name"] as? String } ?? []
            }
            self?.isLoading = false
        }
    }
    
}
