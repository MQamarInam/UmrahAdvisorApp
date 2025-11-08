//
//  TasbihModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 02/09/2025.
//

import Foundation

struct Zikr: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var count: Int = 0
}
