//
//  BookingModel.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 03/12/2024.
//

import Foundation

struct BookingModel: Identifiable {
    var id: String
    var userId: String
    var userEmail: String
    var packageName: String
    var packagePrice: Double
    var packageDays: Int
    var totalPrice: Double
    var numberOfPackages: Int
    var emergencyNumber: String
    var recipients: [[String: Any]]
}
