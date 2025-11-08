//
//  UmrahStepsModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 01/09/2025.
//

import Foundation

struct UmrahStep: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: [String]
    var isCompleted: Bool = false
    
    init(id: UUID = UUID(), title: String, description: [String], isCompleted: Bool = false) {
            self.id = id
            self.title = title
            self.description = description
            self.isCompleted = isCompleted
        }
}
