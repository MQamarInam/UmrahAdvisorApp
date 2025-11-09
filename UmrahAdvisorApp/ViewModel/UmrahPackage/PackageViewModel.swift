import Foundation
import Firebase
import FirebaseFirestore

class PackageViewModel: ObservableObject {
    
    let firestore = Firestore.firestore()
    @Published var packages = [Packages]()
    @Published var isLoading: Bool = false
    
    init() {
        fetchPackagesData()
    }
    
    func savePackageData(
        name: String,
        price: Double,
        days: Int,
        isHot: Bool,
        firstDays: Int,
        nextDays: Int,
        lastDays: Int,
        makkahHotel: String,
        madinahHotel: String,
        roomTypes: String,
        transportType: String,
        flightName: String,
        departure: FlightDetail,
        arrival: FlightDetail,
        completion: @escaping (Bool) -> Void
    ) {
        self.isLoading = true
        let packageData: [String: Any] = [
            "name": name,
            "price": price,
            "days": days,
            "isHot": isHot,
            "firstDays": firstDays,
            "nextDays": nextDays,
            "lastDays": lastDays,
            "makkahHotel": makkahHotel,
            "madinahHotel": madinahHotel,
            "roomTypes": roomTypes,
            "transportType": transportType,
            "flightName": flightName,
            "departure": [
                "sector": departure.sector,
                "date": departure.date,
                "time": departure.time,
                "baggage": departure.baggage
            ],
            "arrival": [
                "sector": arrival.sector,
                "date": arrival.date,
                "time": arrival.time,
                "baggage": arrival.baggage
            ]
        ]
        firestore.collection("Packages").addDocument(data: packageData) { error in
            if let error = error {
                print("Failed to send data to Firestore: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Data successfully saved to Firestore!")
                self.isLoading = false
                completion(true)
            }
        }
    }
    
    func fetchPackagesData() {
        self.isLoading = true
        firestore.collection("Packages").getDocuments { (snapshot, error) in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if let error = error {
                print("Error fetching packages: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            self.packages.removeAll()
            for document in documents {
                let data = document.data()
                let id = document.documentID
                let name = data["name"] as? String ?? "Unknown"
                let price = data["price"] as? Double ?? 0.0
                let days = data["days"] as? Int ?? 0
                let isHot = data["isHot"] as? Bool ?? false
                let firstDays = data["firstDays"] as? Int ?? 0
                let nextDays = data["nextDays"] as? Int ?? 0
                let lastDays = data["lastDays"] as? Int ?? 0
                let makkahHotel = data["makkahHotel"] as? String ?? "Unknown"
                let madinahHotel = data["madinahHotel"] as? String ?? "Unknown"
                let roomTypes = data["roomTypes"] as? String ?? "Not specified"
                let transportType = data["transportType"] as? String ?? "Not specified"
                let flightName = data["flightName"] as? String ?? "Not specified"

                // Fetch departure details
                let departureData = data["departure"] as? [String: Any] ?? [:]
                let departure = FlightDetail(
                    sector: departureData["sector"] as? String ?? "Unknown",
                    date: (departureData["date"] as? Timestamp)?.dateValue() ?? Date(),
                    time: (departureData["time"] as? Timestamp)?.dateValue() ?? Date(),
                    baggage: departureData["baggage"] as? String ?? "Unknown"
                )
                // Fetch arrival details
                let arrivalData = data["arrival"] as? [String: Any] ?? [:]
                let arrival = FlightDetail(
                    sector: arrivalData["sector"] as? String ?? "Unknown",
                    date: (arrivalData["date"] as? Timestamp)?.dateValue() ?? Date(),
                    time: (arrivalData["time"] as? Timestamp)?.dateValue() ?? Date(),
                    baggage: arrivalData["baggage"] as? String ?? "Unknown"
                )
                // Create package object
                let package = Packages(
                    id: id,
                    name: name,
                    price: price,
                    days: days,
                    isHot: isHot,
                    firstDays: firstDays,
                    nextDays: nextDays,
                    lastDays: lastDays,
                    makkahHotel: makkahHotel,
                    madinahHotel: madinahHotel,
                    roomTypes: roomTypes,
                    transportType: transportType,
                    flightName: flightName,
                    departure: departure,
                    arrival: arrival
                )
                self.packages.append(package)
            }
        }
    }

    func deletePackage(at offsets: IndexSet) {
        offsets.map { packages[$0] }.forEach { package in
            if let id = package.id {
                firestore.collection("Packages").document(id).delete { error in
                    if let error = error {
                        print("Error deleting package: \(error.localizedDescription)")
                    } else {
                        print("Package successfully deleted!")
                    }
                }
            }
        }
        packages.remove(atOffsets: offsets)
    }
    
    func updatePackagePrice(packageId: String, newPrice: Double) {
        let updateData: [String: Any] = [
            "price": newPrice
        ]
        
        firestore.collection("Packages").document(packageId).updateData(updateData) { error in
            if let error = error {
                print("Failed to update package price: \(error.localizedDescription)")
            } else {
                print("Package price successfully updated!")
                self.fetchPackagesData()
            }
        }
    }
    
}
