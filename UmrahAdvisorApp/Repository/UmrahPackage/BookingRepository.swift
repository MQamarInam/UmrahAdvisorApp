//
//  BookingRepository.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 03/12/2025.
//

import Foundation

class BookingRepository: BookingProtocol {
    
    let service: BookingProtocol
    
    init(service: BookingProtocol = BookingService()) {
        self.service = service
    }
    
    func saveBookingRequest(package: Packages, totalPrice: Double, numberOfPackages: Int, whatsAppNumber: String, recipients: [RecipientDetail], completion: @escaping (Result<Void, Error>) -> Void) {
        service.saveBookingRequest(package: package, totalPrice: totalPrice, numberOfPackages: numberOfPackages, whatsAppNumber: whatsAppNumber, recipients: recipients, completion: completion)
    }
    
    func fetchBookingRequests(completion: @escaping (Result<[BookingModel], Error>) -> Void) {
        service.fetchBookingRequests(completion: completion)
    }
    
    func deleteBookingRequest(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        service.deleteBookingRequest(id: id, completion: completion)
    }
    
    func fetchUserBookingRequests(userId: String, completion: @escaping (Result<[BookingModel], Error>) -> Void) {
        service.fetchUserBookingRequests(userId: userId, completion: completion)
    }
    
}
