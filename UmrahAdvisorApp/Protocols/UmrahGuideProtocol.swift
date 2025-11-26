//
//  UmrahGuideProtocol.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 26/11/2025.
//

import Foundation

protocol UmrahGuideServiceProtocol {
    func saveStep(_ step: [UmrahStep])
    func loadStep() -> [UmrahStep]
}

protocol UmrahGuideRepositoryProtocol {
    func getSteps() -> [UmrahStep]
    func updateSteps(_ steps: [UmrahStep])
}
