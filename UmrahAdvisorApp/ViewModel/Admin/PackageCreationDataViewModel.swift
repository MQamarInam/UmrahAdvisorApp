//
//  PackageDataViewModel.swift
//  UmrahBooking
//
//  Created by Qaim's Macbook  on 16/04/2025.
//

import Foundation
import Firebase

class PackageCreationDataViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var day: String = ""
    @Published var isHot: Bool = false
    @Published var firstdays: String = ""
    @Published var nextdays: String = ""
    @Published var lastdays: String = ""
    @Published var selectedMakkahHotel: String = ""
    @Published var selectedMadinahHotel: String = ""
    @Published var selectedFlightName: String = ""
    @Published var selectedRoomType: String = ""
    let roomOptions = ["Private Room", "Shared Room"]
    @Published var selectedTransport: String = ""
    let transportOptions = ["Private Transport", "Local Transport"]
    @Published var selectedDepartureSector: String = ""
    let departureSectorOptions = ["LHR-JDH", "LHR-MDN"]
    @Published var departureDate = Date()
    @Published var departureTime = Date()
    @Published var departureBaggage: String = ""
    @Published var selectedArrivalSector: String = ""
    let arrivalSectorOptions = ["JDH-LHR", "MDN-LHR"]
    @Published var arrivalDate = Date()
    @Published var arrivalTime = Date()
    @Published var arrivalBaggage: String = ""
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var makkahHotels: [String] = []
    @Published var madinahHotels: [String] = []
    @Published var flightOptions: [String] = []
    @Published var isLoading = false
    
    private var db = Firestore.firestore()
    @Published var fm: PackageViewModel = PackageViewModel()
    
    init() {
        fetchDataFromFirebase()
    }
    
    func validatePackageData() -> Bool {
        if name.isEmpty {
            alertMessage = "Enter Package Name."
            showAlert = true
            return false
        }
        if price.isEmpty {
            alertMessage = "Enter Package Price."
            showAlert = true
            return false
        }
        if day.isEmpty {
            alertMessage = "Enter Package Duration (Days)."
            showAlert = true
            return false
        }
        if firstdays.isEmpty {
            alertMessage = "Enter details for First Days itinerary."
            showAlert = true
            return false
        }
        if nextdays.isEmpty {
            alertMessage = "Enter details for Next Days itinerary."
            showAlert = true
            return false
        }
        if lastdays.isEmpty {
            alertMessage = "Enter details for Last Days itinerary."
            showAlert = true
            return false
        }
        if selectedMakkahHotel.isEmpty {
            alertMessage = "Select Makkah Hotel."
            showAlert = true
            return false
        }
        if selectedMadinahHotel.isEmpty {
            alertMessage = "Select Madinah Hotel."
            showAlert = true
            return false
        }
        if selectedFlightName.isEmpty {
            alertMessage = "Select Flight Name."
            showAlert = true
            return false
        }
        if selectedRoomType.isEmpty {
            alertMessage = "Select Room Type."
            showAlert = true
            return false
        }
        if selectedTransport.isEmpty {
            alertMessage = "Select Transport Type."
            showAlert = true
            return false
        }
        if selectedDepartureSector.isEmpty {
            alertMessage = "Select Departure Sector."
            showAlert = true
            return false
        }
        if departureBaggage.isEmpty {
            alertMessage = "Enter Departure Baggage Details."
            showAlert = true
            return false
        }
        if selectedArrivalSector.isEmpty {
            alertMessage = "Select Arrival Sector."
            showAlert = true
            return false
        }
        if arrivalBaggage.isEmpty {
            alertMessage = "Enter Arrival Baggage Details."
            showAlert = true
            return false
        }
        return true
    }

    
    func clearForm() {
        name = ""
        price = ""
        day = ""
        firstdays = ""
        nextdays = ""
        lastdays = ""
        selectedMakkahHotel = ""
        selectedMadinahHotel = ""
        selectedRoomType = ""
        selectedTransport = ""
        selectedFlightName = ""
        selectedDepartureSector = ""
        selectedArrivalSector = ""
        departureBaggage = ""
        arrivalBaggage = ""
    }
    
    func addPackageAction() {
        guard let priceValue = Double(price),
              let dayValue = Int(day),
              let firstDaysValue = Int(firstdays),
              let nextDaysValue = Int(nextdays),
              let lastDaysValue = Int(lastdays) else {
            return
        }
        let departure = FlightDetail(
            sector: selectedDepartureSector,
            date: departureDate,
            time: departureTime,
            baggage: departureBaggage
        )
        let arrival = FlightDetail(
            sector: selectedArrivalSector,
            date: arrivalDate,
            time: arrivalTime,
            baggage: arrivalBaggage
        )
        fm.savePackageData(
            name: name,
            price: priceValue,
            days: dayValue,
            isHot: isHot,
            firstDays: firstDaysValue,
            nextDays: nextDaysValue,
            lastDays: lastDaysValue,
            makkahHotel: selectedMakkahHotel,
            madinahHotel: selectedMadinahHotel,
            roomTypes: selectedRoomType,
            transportType: selectedTransport,
            flightName: selectedFlightName,
            departure: departure,
            arrival: arrival
        ) { success in
            if success {
                self.showAlert = true
                self.clearForm()
            } else {
                
            }
        }
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
