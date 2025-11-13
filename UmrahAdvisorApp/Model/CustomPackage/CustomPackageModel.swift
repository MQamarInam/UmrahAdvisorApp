//
//  CustomPackageModel.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 08/03/2025.

import Foundation

struct Hotel: Identifiable, Hashable {
    var id: String?
    let name: String
    var rooms: [Room]
}

struct Room: Identifiable, Hashable {
    var id: String?
    let type: String
    var price: Double
}

struct Flight: Identifiable, Hashable {
    var id: String?
    let name: String
    var durations: [FlightDuration]
}

struct FlightDuration: Identifiable, Hashable {
    var id: String?
    let days: Int
    var price: Double
}

struct Transportation: Identifiable, Hashable {
    var id: String?
    let type: String
    var price: Double
}

struct Ziyarat: Identifiable, Hashable {
    var id: String?
    let name: String
    var price: Double
}

struct CustomPackageRequest: Identifiable {
    var id: String
    var numberOfPackages: Int
    var mobileNumber: String
    var recipients: [[String: Any]]
    var makkahHotel: String
    var madinahHotel: String
    var makkahRoom: String
    var madinahRoom: String
    var flight: String
    var duration: Int
    var transportation: String
    var makkahDays: Int
    var madinahDays: Int
    var travelDate: Date
    var ziyarat: [String]
    var totalPrice: Double
    var grandTotalPrice: Double
    var identifiableRecipients: [RecipientDetail] {
        recipients.map { recipient in
            RecipientDetail(
                surName: recipient["surname"] as? String ?? "",
                givenName: recipient["givenName"] as? String ?? "",
                passportNumber: recipient["passportNumber"] as? String ?? "",
                dateOfBirth: parseDate(from: recipient["dateOfBirth"] as? String),
                expiryDate: parseDate(from: recipient["expiryDate"] as? String)
            )
        }
    }
    private func parseDate(from dateString: String?) -> Date {
        guard let dateString = dateString else { return Date() }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateString) ?? Date()
    }
}
