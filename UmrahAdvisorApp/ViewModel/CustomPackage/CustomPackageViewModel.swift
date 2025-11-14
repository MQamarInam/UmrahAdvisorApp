import Foundation
import Firebase
import FirebaseFirestore

class CustomPackageViewModel: ObservableObject {
    
    let firestore = Firestore.firestore()
    @Published var makkahHotels: [Hotel] = []
    @Published var madinahHotels: [Hotel] = []
    @Published var flights: [Flight] = []
    @Published var transportations: [Transportation] = []
    @Published var ziyaratList: [Ziyarat] = []
    @Published var customPackageRequests: [CustomPackageRequest] = []
    @Published var isLoading = false
    
    @Published var numberOfPackages = 1
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var selectedMakkahHotel: Hotel?
    @Published var selectedMadinahHotel: Hotel?
    @Published var selectedMakkahRoom: Room?
    @Published var selectedMadinahRoom: Room?
    @Published var selectedFlight: Flight?
    @Published var selectedDuration: FlightDuration?
    @Published var selectedTransportation: Transportation?
    @Published var makkahDays: Int = 0
    @Published var madinahDays: Int = 0
    @Published var travelDate = Date()
    @Published var isDateSelected = false
    @Published var selectedZiyarat: Set<Ziyarat> = []
    
    var totalDays: Int {
        makkahDays + madinahDays
    }
    
    var totalPrice: Double {
        let makkahRoomPrice = (selectedMakkahRoom?.price ?? 0) * Double(makkahDays)
        let madinahRoomPrice = (selectedMadinahRoom?.price ?? 0) * Double(madinahDays)
        let flightPrice = selectedDuration?.price ?? 0
        let transportPrice = selectedTransportation?.price ?? 0
        let ziyaratPrice = selectedZiyarat.reduce(0) { $0 + $1.price }
        return makkahRoomPrice + madinahRoomPrice + flightPrice + transportPrice + ziyaratPrice
    }
    
    var grandTotalPrice: Double {
        return totalPrice * Double(numberOfPackages)
    }
    
    init() {
        fetchDataFromFirebase()
    }
    
    func fetchDataFromFirebase() {
        isLoading = true
        firestore.collection("MakkahHotels").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching Makkah hotels: \(error.localizedDescription)")
            } else if let documents = snapshot?.documents {
                self.makkahHotels = documents.compactMap { document in
                    let data = document.data()
                    guard let name = data["name"] as? String,
                          let roomsData = data["rooms"] as? [[String: Any]] else {
                        return nil
                    }
                    let rooms = roomsData.compactMap { roomData -> Room? in
                        guard let type = roomData["type"] as? String,
                              let price = roomData["price"] as? Double else {
                            return nil
                        }
                        return Room(id: UUID().uuidString, type: type, price: price)
                    }
                    return Hotel(id: document.documentID, name: name, rooms: rooms)
                }
            }
        }
        
        // Fetch Madinah Hotels
        firestore.collection("MadinahHotels").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching Madinah hotels: \(error.localizedDescription)")
            } else if let documents = snapshot?.documents {
                self.madinahHotels = documents.compactMap { document in
                    let data = document.data()
                    guard let name = data["name"] as? String,
                          let roomsData = data["rooms"] as? [[String: Any]] else {
                        return nil
                    }
                    let rooms = roomsData.compactMap { roomData -> Room? in
                        guard let type = roomData["type"] as? String,
                              let price = roomData["price"] as? Double else {
                            return nil
                        }
                        return Room(id: UUID().uuidString, type: type, price: price)
                    }
                    return Hotel(id: document.documentID, name: name, rooms: rooms)
                }
            }
        }
        
        // Fetch Flights
        firestore.collection("Flights").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching flights: \(error.localizedDescription)")
            } else if let documents = snapshot?.documents {
                self.flights = documents.compactMap { document in
                    let data = document.data()
                    guard let name = data["name"] as? String,
                          let durationsData = data["durations"] as? [[String: Any]] else {
                        return nil
                    }
                    let durations = durationsData.compactMap { durationData -> FlightDuration? in
                        guard let days = durationData["days"] as? Int,
                              let price = durationData["price"] as? Double else {
                            return nil
                        }
                        return FlightDuration(id: UUID().uuidString, days: days, price: price)
                    }
                    return Flight(id: document.documentID, name: name, durations: durations)
                }
            }
        }
        
        // Fetch Transportations
        firestore.collection("Transportations").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching transportations: \(error.localizedDescription)")
            } else if let documents = snapshot?.documents {
                self.transportations = documents.compactMap { document in
                    let data = document.data()
                    guard let type = data["type"] as? String,
                          let price = data["price"] as? Double else {
                        return nil
                    }
                    return Transportation(id: document.documentID, type: type, price: price)
                }
            }
        }
        
        // Fetch Ziyarats
        firestore.collection("Ziyarats").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching Ziyarats: \(error.localizedDescription)")
            } else if let documents = snapshot?.documents {
                self.ziyaratList = documents.compactMap { document in
                    let data = document.data()
                    guard let name = data["name"] as? String,
                          let price = data["price"] as? Double else {
                        return nil
                    }
                    return Ziyarat(id: document.documentID, name: name, price: price)
                }
            }
            self.isLoading = false
        }
    }
    
    // Delete Makkah Hotel
    func deleteMakkahHotel(_ hotel: Hotel) {
        let id = hotel.id
        firestore.collection("MakkahHotels").document(id).delete { error in
            if let error = error {
                print("Error deleting Makkah hotel: \(error.localizedDescription)")
            } else {
                // Remove from local array
                self.makkahHotels.removeAll { $0.id == id }
                print("Makkah hotel deleted successfully!")
            }
        }
    }
    
    // Delete Madinah Hotel
    func deleteMadinahHotel(_ hotel: Hotel) {
        let id = hotel.id
        firestore.collection("MadinahHotels").document(id).delete { error in
            if let error = error {
                print("Error deleting Madinah hotel: \(error.localizedDescription)")
            } else {
                // Remove from local array
                self.madinahHotels.removeAll { $0.id == id }
                print("Madinah hotel deleted successfully!")
            }
        }
    }
    
    // Delete Flight
    func deleteFlight(_ flight: Flight) {
        let id = flight.id
        firestore.collection("Flights").document(id).delete { error in
            if let error = error {
                print("Error deleting flight: \(error.localizedDescription)")
            } else {
                // Remove from local array
                self.flights.removeAll { $0.id == id }
                print("Flight deleted successfully!")
            }
        }
    }
    
    // Delete Transportation
    func deleteTransportation(_ transportation: Transportation) {
        let id = transportation.id
        firestore.collection("Transportations").document(id).delete { error in
            if let error = error {
                print("Error deleting transportation: \(error.localizedDescription)")
            } else {
                // Remove from local array
                self.transportations.removeAll { $0.id == id }
                print("Transportation deleted successfully!")
            }
        }
    }
    
    // Delete Ziyarat
    func deleteZiyarat(_ ziyarat: Ziyarat) {
        let id = ziyarat.id
        firestore.collection("Ziyarats").document(id).delete { error in
            if let error = error {
                print("Error deleting Ziyarat: \(error.localizedDescription)")
            } else {
                // Remove from local array
                self.ziyaratList.removeAll { $0.id == id }
                print("Ziyarat deleted successfully!")
            }
        }
    }
    
    func updateFlightDurationPrice(flightId: String, durationId: String, newPrice: Double) {
        guard let flightIndex = flights.firstIndex(where: { $0.id == flightId }) else {
            print("Flight not found")
            return
        }
        guard let durationIndex = flights[flightIndex].durations.firstIndex(where: { $0.id == durationId }) else {
            print("Duration not found")
            return
        }
        flights[flightIndex].durations[durationIndex].price = newPrice
        updateFlightToFirebase(flight: flights[flightIndex])
    }
    
    func updateFlightToFirebase(flight: Flight) {
        let flightId = flight.id
        
        let flightData: [String: Any] = [
            "name": flight.name,
            "durations": flight.durations.map { ["days": $0.days, "price": $0.price] }
        ]
        firestore.collection("Flights").document(flightId).setData(flightData) { error in
            if let error = error {
                print("Error updating flight: \(error.localizedDescription)")
            } else {
                print("Flight updated successfully!")
            }
        }
    }
    
    func updateMakkahHotelRoomPrice(hotelId: String, roomId: String, newPrice: Double) {
        guard let hotelIndex = makkahHotels.firstIndex(where: { $0.id == hotelId }) else {
            print("Hotel not found")
            return
        }
        guard let roomIndex = makkahHotels[hotelIndex].rooms.firstIndex(where: { $0.id == roomId }) else {
            print("Room not found")
            return
        }
        makkahHotels[hotelIndex].rooms[roomIndex].price = newPrice
        updateMakkahHotelToFirebase(hotel: makkahHotels[hotelIndex])
    }
    
    func updateMakkahHotelToFirebase(hotel: Hotel) {
        let hotelId = hotel.id
        
        let hotelData: [String: Any] = [
            "name": hotel.name,
            "rooms": hotel.rooms.map { ["type": $0.type, "price": $0.price] }
        ]
        firestore.collection("MakkahHotels").document(hotelId).setData(hotelData) { error in
            if let error = error {
                print("Error updating hotel: \(error.localizedDescription)")
            } else {
                print("Hotel updated successfully!")
            }
        }
    }
    
    func updateMadinahHotelRoomPrice(hotelId: String, roomId: String, newPrice: Double) {
        guard let hotelIndex = madinahHotels.firstIndex(where: { $0.id == hotelId }) else {
            print("Hotel not found")
            return
        }
        guard let roomIndex = madinahHotels[hotelIndex].rooms.firstIndex(where: { $0.id == roomId }) else {
            print("Room not found")
            return
        }
        madinahHotels[hotelIndex].rooms[roomIndex].price = newPrice
        updateMadinahHotelToFirebase(hotel: madinahHotels[hotelIndex])
    }
    
    func updateMadinahHotelToFirebase(hotel: Hotel) {
        let hotelId = hotel.id
        let hotelData: [String: Any] = [
            "name": hotel.name,
            "rooms": hotel.rooms.map { ["type": $0.type, "price": $0.price] }
        ]
        firestore.collection("MadinahHotels").document(hotelId).setData(hotelData) { error in
            if let error = error {
                print("Error updating hotel: \(error.localizedDescription)")
            } else {
                print("Hotel updated successfully!")
            }
        }
    }
    
    func updateZiyaratPrice(ziyaratId: String, newPrice: Double) {
        guard let ziyaratIndex = ziyaratList.firstIndex(where: { $0.id == ziyaratId }) else {
            print("Ziyarat not found")
            return
        }
        ziyaratList[ziyaratIndex].price = newPrice
        updateZiyaratToFirebase(ziyarat: ziyaratList[ziyaratIndex])
    }
    
    func updateZiyaratToFirebase(ziyarat: Ziyarat) {
        let ziyaratId = ziyarat.id
        let ziyaratData: [String: Any] = [
            "name": ziyarat.name,
            "price": ziyarat.price
        ]
        firestore.collection("Ziyarats").document(ziyaratId).setData(ziyaratData) { error in
            if let error = error {
                print("Error updating Ziyarat: \(error.localizedDescription)")
            } else {
                print("Ziyarat updated successfully!")
            }
        }
    }
    
    func updateTransportationPrice(transportationId: String, newPrice: Double) {
        guard let transportationIndex = transportations.firstIndex(where: { $0.id == transportationId }) else {
            print("Transportation not found")
            return
        }
        transportations[transportationIndex].price = newPrice
        updateTransportationToFirebase(transportation: transportations[transportationIndex])
    }
    
    func updateTransportationToFirebase(transportation: Transportation) {
        let transportationId = transportation.id
        let transportationData: [String: Any] = [
            "type": transportation.type,
            "price": transportation.price
        ]
        firestore.collection("Transportations").document(transportationId).setData(transportationData) { error in
            if let error = error {
                print("Error updating Transportation: \(error.localizedDescription)")
            } else {
                print("Transportation updated successfully!")
            }
        }
    }
        
    func sendCustomPackageRequest(data: [String: Any], completion: @escaping (Bool) -> Void) {
        firestore.collection("PackageRequests").addDocument(data: data) { error in
            if let error = error {
                print("Error sending package request: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Package request sent successfully!")
                completion(true)
            }
        }
    }
    
    func fetchCustomPackageRequestsData() {
        firestore.collection("PackageRequests").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            self.customPackageRequests = documents.compactMap { document in
                let data = document.data()
                return CustomPackageRequest(
                    id: document.documentID,
                    numberOfPackages: data["numberOfPackages"] as? Int ?? 0,
                    mobileNumber: data["mobileNumber"] as? String ?? "",
                    recipients: data["recipients"] as? [[String: Any]] ?? [],
                    makkahHotel: data["makkahHotel"] as? String ?? "",
                    madinahHotel: data["madinahHotel"] as? String ?? "",
                    makkahRoom: data["makkahRoom"] as? String ?? "",
                    madinahRoom: data["madinahRoom"] as? String ?? "",
                    flight: data["flight"] as? String ?? "",
                    duration: data["duration"] as? Int ?? 0,
                    transportation: data["transportation"] as? String ?? "",
                    makkahDays: data["makkahDays"] as? Int ?? 0,
                    madinahDays: data["madinahDays"] as? Int ?? 0,
                    travelDate: self.parseDate(from: data["travelDate"] as? String),
                    ziyarat: data["ziyarat"] as? [String] ?? [],
                    totalPrice: data["totalPrice"] as? Double ?? 0.0,
                    grandTotalPrice: data["grandTotalPrice"] as? Double ?? 0.0
                )
            }
        }
    }

    private func parseDate(from dateString: String?) -> Date {
        guard let dateString = dateString else { return Date() }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateString) ?? Date()
    }
    
    func deleteRequest(_ request: CustomPackageRequest, completion: @escaping (Bool) -> Void) {
        let documentID = request.id
        firestore.collection("PackageRequests").document(documentID).delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
                completion(false)
            } else {
                print("Document successfully deleted")
                DispatchQueue.main.async {
                    self.customPackageRequests.removeAll { $0.id == documentID }
                }
                completion(true)
            }
        }
    }
    
}
