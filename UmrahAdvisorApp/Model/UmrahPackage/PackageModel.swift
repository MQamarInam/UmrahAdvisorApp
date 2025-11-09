import Firebase
import FirebaseFirestore

struct Packages: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let price: Double
    let days: Int
    var isHot: Bool
    
    // Itinerary Details
    let firstDays: Int
    let nextDays: Int
    let lastDays: Int
    
    // Accommodation Details
    let makkahHotel: String
    let madinahHotel: String
    
    // Room Type
    var roomTypes: String
    
    // Transportation
    var transportType: String
    
    // Airline Details
    var flightName: String
    var departure: FlightDetail
    var arrival: FlightDetail
}

struct FlightDetail: Codable {
    let sector: String
    let date: Date
    let time: Date
    let baggage: String
}
