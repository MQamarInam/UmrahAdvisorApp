//
//  BookingService.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 03/12/2025.

import Foundation
import Firebase
import FirebaseAuth

class BookingService: BookingProtocol {
    
    @Published var bookingRequests: [BookingModel] = []
    private let db = Firestore.firestore()
    
    func saveBookingRequest(package: Packages, totalPrice: Double, numberOfPackages: Int, whatsAppNumber: String,
        recipients: [RecipientDetail], completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "BookingService", code: 401, userInfo: [NSLocalizedDescriptionKey : "User not authenticated"])))
            return
        }
        let bookingData: [String: Any] = [
            "userId": user.uid,
            "userEmail": user.email ?? "No Email",
            "package": [
                "name": package.name,
                "price": package.price,
                "days": package.days
            ],
            "totalPrice": totalPrice,
            "numberOfPackages": numberOfPackages,
            "whatsAppNumber": whatsAppNumber,
            "recipients": recipients.map { r in
                [
                    "surName": r.surName,
                    "givenName": r.givenName,
                    "passportNumber": r.passportNumber,
                    "dateOfBirth": r.dateOfBirth,
                    "expiryDate": r.expiryDate
                ]
            }
        ]
        db.collection("PackageRequests").addDocument(data: bookingData) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    func fetchBookingRequests(completion: @escaping (Result<[BookingModel], Error>) -> Void) {
        db.collection("PackageRequests").getDocuments { [weak self] snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            let results: [BookingModel] = snapshot?.documents.compactMap { doc in
                let data = doc.data()
                guard
                    let userId = data["userId"] as? String,
                    let userEmail = data["userEmail"] as? String,
                    let package = data["package"] as? [String: Any],
                    let packageName = package["name"] as? String,
                    let packagePrice = package["price"] as? Double,
                    let packageDays = package["days"] as? Int,
                    let totalPrice = data["totalPrice"] as? Double,
                    let numberOfPackages = data["numberOfPackages"] as? Int,
                    let whatsAppNumber = data["whatsAppNumber"] as? String,
                    let recipients = data["recipients"] as? [[String: Any]]
                else { return nil }
                return BookingModel(
                    id: doc.documentID,
                    userId: userId,
                    userEmail: userEmail,
                    packageName: packageName,
                    packagePrice: packagePrice,
                    packageDays: packageDays,
                    totalPrice: totalPrice,
                    numberOfPackages: numberOfPackages,
                    whatsAppNumber: whatsAppNumber,
                    recipients: recipients
                )
            } ?? []
            DispatchQueue.main.async {
                self?.bookingRequests = results
            }
            completion(.success(results))
        }
    }
    
    func deleteBookingRequest(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("PackageRequests").document(id).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    func fetchUserBookingRequests(userId: String, completion: @escaping (Result<[BookingModel], Error>) -> Void) {
        db.collection("PackageRequests").whereField("userId", isEqualTo: userId).getDocuments { [weak self] snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            let results: [BookingModel] = snapshot?.documents.compactMap { doc in
                let data = doc.data()
                guard
                    let userId = data["userId"] as? String,
                    let userEmail = data["userEmail"] as? String,
                    let package = data["package"] as? [String: Any],
                    let packageName = package["name"] as? String,
                    let packagePrice = package["price"] as? Double,
                    let packageDays = package["days"] as? Int,
                    let totalPrice = data["totalPrice"] as? Double,
                    let numberOfPackages = data["numberOfPackages"] as? Int,
                    let whatsAppNumber = data["whatsAppNumber"] as? String,
                    let recipients = data["recipients"] as? [[String: Any]]
                else { return nil }
                return BookingModel(
                    id: doc.documentID,
                    userId: userId,
                    userEmail: userEmail,
                    packageName: packageName,
                    packagePrice: packagePrice,
                    packageDays: packageDays,
                    totalPrice: totalPrice,
                    numberOfPackages: numberOfPackages,
                    whatsAppNumber: whatsAppNumber,
                    recipients: recipients
                )
            } ?? []
            DispatchQueue.main.async {
                self?.bookingRequests = results
            }
            completion(.success(results))
        }
    }
    
}
