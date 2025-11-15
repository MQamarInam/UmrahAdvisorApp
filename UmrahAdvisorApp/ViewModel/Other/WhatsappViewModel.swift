//
//  WhatsappViewModel.swift
//  UltimateUmrahAdvisor
//
//  Created by Qaim's Macbook  on 15/11/2025.
//

import Foundation
import SwiftUI

class WhatsappViewModel: ObservableObject {
    
    private let phoneNumber = "+923074899825"
    func openWhatsApp() {
        let urlString = "https://wa.me/\(phoneNumber)"
        guard let url = URL(string: urlString) else {
            print("Invalid WhatsApp URL")
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { success in
                if !success {
                    print("Failed to open WhatsApp")
                }
            }
        } else {
            print("WhatsApp is not installed")
        }
    }
    
}
