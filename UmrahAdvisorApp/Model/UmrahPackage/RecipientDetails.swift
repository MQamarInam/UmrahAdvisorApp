//
//  RecipientDetails.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 10/11/2025.
//

import Foundation

struct RecipientDetail: Identifiable {
    var id = UUID()
    var surName: String = ""
    var givenName: String = ""
    var passportNumber: String = ""
    var dateOfBirth: Date = Date()
    var expiryDate: Date = Date()
    var mobileNumber: String = ""
}
