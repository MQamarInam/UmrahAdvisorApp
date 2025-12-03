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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: BookingProtocol
    
    init(repository: BookingProtocol = BookingRepository()) {
        self.repository = repository
    }
    
    func saveBookingRequest(package: Packages, totalPrice: Double, numberOfPackages: Int, whatsAppNumber: String, recipients: [RecipientDetail]) {
        isLoading = true
        repository.saveBookingRequest(package: package, totalPrice: totalPrice, numberOfPackages: numberOfPackages, whatsAppNumber: whatsAppNumber, recipients: recipients) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    print("Booking saved successfully!")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to save booking: \(error.localizedDescription)")
                }
            }
        }
    }

    func fetchBookingRequests() {
        isLoading = true
        repository.fetchBookingRequests { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let bookings):
                    self?.bookingRequests = bookings
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to fetch bookings: \(error.localizedDescription)")
                }
            }
        }
    }

    func deleteBookingRequest(at indexSet: IndexSet) {
        indexSet.forEach { [weak self] index in
            guard let self = self else { return }
            let booking = self.bookingRequests[index]
            repository.deleteBookingRequest(id: booking.id) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.bookingRequests.remove(at: index)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print("Failed to delete booking: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func fetchUserBookingRequests(userId: String) {
        isLoading = true
        repository.fetchUserBookingRequests(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let bookings):
                    self?.bookingRequests = bookings
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to fetch user bookings: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
