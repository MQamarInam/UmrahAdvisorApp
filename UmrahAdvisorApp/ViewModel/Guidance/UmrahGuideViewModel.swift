//
//  UmrahGuideViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 02/09/2025.
//

import Foundation
import SwiftUI

class UmrahGuideViewModel: ObservableObject {
    
    @Published var currentStepIndex: Int = 0
    @Published var steps: [UmrahStep] = []
    
    private let repo: UmrahGuideRepositoryProtocol

    init(repository: UmrahGuideRepositoryProtocol = UmrahGuideRepository(service: UmrahGuideService())) {
        self.repo = repository
        self.steps = repo.getSteps()
    }
    
    func nextStep() {
        if currentStepIndex < steps.count - 1 {
            currentStepIndex += 1
        }
    }
    
    func previousStep() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
    }
    
    func toggleCompletion() {
        steps[currentStepIndex].isCompleted.toggle()
        repo.updateSteps(steps)
    }
    
}

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: {
                self.wrappedValue = $0
                handler()
            }
        )
    }
}
