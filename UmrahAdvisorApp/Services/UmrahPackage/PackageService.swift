//
//  BookingPackageService.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 02/12/2025.

import Foundation
import Firebase

class PackageService: PackageProtocol {
    
    private let firestore = Firestore.firestore()
        
    func savePackage(_ package: Packages, completion: @escaping (Result<Void, Error>) -> Void) {
        let data: [String: Any] = [
            "name": package.name,
            "price": package.price,
            "days": package.days,
            "isHot": package.isHot,
            "firstDays": package.firstDays,
            "nextDays": package.nextDays,
            "lastDays": package.lastDays,
            "makkahHotel": package.makkahHotel,
            "madinahHotel": package.madinahHotel,
            "roomTypes": package.roomTypes,
            "transportType": package.transportType,
            "flightName": package.flightName,
            "departure": [
                "sector": package.departure.sector,
                "date": package.departure.date,
                "time": package.departure.time,
                "baggage": package.departure.baggage
            ],
            "arrival": [
                "sector": package.arrival.sector,
                "date": package.arrival.date,
                "time": package.arrival.time,
                "baggage": package.arrival.baggage
            ]
        ]
        firestore.collection("Packages").addDocument(data: data) { error in
            if let error = error { completion(.failure(error)) }
            else { completion(.success(())) }
        }
    }
    
    func fetchPackages(completion: @escaping (Result<[Packages], Error>) -> Void) {
        firestore.collection("Packages").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let docs = snapshot?.documents else {
                completion(.success([]))
                return
            }
            var result: [Packages] = []
            for doc in docs {
                let data = doc.data()
                let departureData = data["departure"] as? [String: Any] ?? [:]
                let arrivalData = data["arrival"] as? [String: Any] ?? [:]
                let departure = FlightDetail(
                    sector: departureData["sector"] as? String ?? "",
                    date: (departureData["date"] as? Timestamp)?.dateValue() ?? Date(),
                    time: (departureData["time"] as? Timestamp)?.dateValue() ?? Date(),
                    baggage: departureData["baggage"] as? String ?? ""
                )
                let arrival = FlightDetail(
                    sector: arrivalData["sector"] as? String ?? "",
                    date: (arrivalData["date"] as? Timestamp)?.dateValue() ?? Date(),
                    time: (arrivalData["time"] as? Timestamp)?.dateValue() ?? Date(),
                    baggage: arrivalData["baggage"] as? String ?? ""
                )
                let package = Packages(
                    id: doc.documentID,
                    name: data["name"] as? String ?? "",
                    price: data["price"] as? Double ?? 0.0,
                    days: data["days"] as? Int ?? 0,
                    isHot: data["isHot"] as? Bool ?? false,
                    firstDays: data["firstDays"] as? Int ?? 0,
                    nextDays: data["nextDays"] as? Int ?? 0,
                    lastDays: data["lastDays"] as? Int ?? 0,
                    makkahHotel: data["makkahHotel"] as? String ?? "",
                    madinahHotel: data["madinahHotel"] as? String ?? "",
                    roomTypes: data["roomTypes"] as? String ?? "",
                    transportType: data["transportType"] as? String ?? "",
                    flightName: data["flightName"] as? String ?? "",
                    departure: departure,
                    arrival: arrival
                )
                result.append(package)
            }
            completion(.success(result))
        }
    }
        
    func deletePackage(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firestore.collection("Packages").document(id).delete { error in
            if let error = error { completion(.failure(error)) }
            else { completion(.success(())) }
        }
    }
    
    func updatePackagePrice(id: String, newPrice: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        firestore.collection("Packages").document(id).updateData(["price": newPrice]) { error in
            if let error = error { completion(.failure(error)) }
            else { completion(.success(())) }
        }
    }
    
}
