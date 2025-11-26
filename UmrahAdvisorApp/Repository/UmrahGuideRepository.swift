//
//  UmrahGuideRepository.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 26/11/2025.
//

import Foundation

class UmrahGuideRepository: UmrahGuideRepositoryProtocol {

    private let service: UmrahGuideServiceProtocol

    init(service: UmrahGuideServiceProtocol) {
        self.service = service
    }

    func getSteps() -> [UmrahStep] {
        return service.loadStep()
    }

    func updateSteps(_ steps: [UmrahStep]) {
        service.saveStep(steps)
    }
    
}
