//
//  BookingViewModel.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 03/12/2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class BookingViewModel: ObservableObject {
    
    @Published var bookingRequests: [BookingModel] = []
    private let db = Firestore.firestore()
    
    func saveBookingRequest(package: Packages, totalPrice: Double, numberOfPackages: Int, whatsAppNumber: String, recipients: [RecipientDetail]) {
        guard let user = Auth.auth().currentUser else {
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
            "recipients": recipients.map { recipient in
                [
                    "surName": recipient.surName,
                    "givenName": recipient.givenName,
                    "passportNumber": recipient.passportNumber,
                    "dateOfBirth": recipient.dateOfBirth,
                    "expiryDate": recipient.expiryDate
                ]
            }
        ]
        db.collection("PackageRequests").addDocument(data: bookingData) { error in
            if let error = error {
                print("Failed to create booking: \(error.localizedDescription)")
            } else {
                print("Booking successfully created!")
            }
        }
    }

    func fetchBookingRequests() {
        db.collection("PackageRequests").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching booking requests: \(error.localizedDescription)")
                return
            }
            self.bookingRequests = snapshot?.documents.compactMap { doc in
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
        }
    }

    func deleteBookingRequest(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let bookingRequest = bookingRequests[index]
            db.collection("PackageRequests").document(bookingRequest.id).delete { error in
                if let error = error {
                    print("Error deleting booking request: \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        self.bookingRequests.remove(at: index)
                    }
                }
            }
        }
    }
    
    func fetchUserBookingRequests(userId: String) {
        db.collection("PackageRequests")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching user booking requests: \(error.localizedDescription)")
                    return
                }
                self.bookingRequests = snapshot?.documents.compactMap { doc in
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
            }
    }
    
}
