//
//  BookingProtocol.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 03/12/2025.
//

import Foundation

protocol BookingProtocol {
    
    func saveBookingRequest(
        package: Packages,
        totalPrice: Double,
        numberOfPackages: Int,
        whatsAppNumber: String,
        recipients: [RecipientDetail],
        completion: @escaping (Result<Void, Error>) -> Void
    )
    func fetchBookingRequests(completion: @escaping (Result<[BookingModel], Error>) -> Void)
    func deleteBookingRequest(id: String, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchUserBookingRequests(userId: String, completion: @escaping (Result<[BookingModel], Error>) -> Void)
    
}

