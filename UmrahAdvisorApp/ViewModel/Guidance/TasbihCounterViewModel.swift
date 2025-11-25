//
//  TasbihCounterViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 02/09/2025.
//

import Foundation
import SwiftUI

class TasbihCounterViewModel: TasbihCounterProtocol, ObservableObject {
    
    @Published var zikrs: [Zikr] = [
        Zikr(name: "Subhanallah"),
        Zikr(name: "Alhamdulillah"),
        Zikr(name: "Allahu Akbar")
    ]
    
    @Published var selectedZikrIndex: Int = 0
    @Published var goal: Int = 100
    @Published var isGoalReached: Bool = false
    
    private let repository: TasbihRepositoryProtocol
    
    init(repository: TasbihRepositoryProtocol = TasbihRepository()) {
        self.repository = repository
        loadCounts()
        checkGoal()
    }
    
    var selectedZikr: Zikr {
        zikrs[selectedZikrIndex]
    }
    
    func incrementCounter() {
        zikrs[selectedZikrIndex].count += 1
        saveCounts()
        checkGoal()
    }
    
    func resetCounter() {
        zikrs[selectedZikrIndex].count = 0
        saveCounts()
        checkGoal()
    }
    
    func checkGoal() {
        if zikrs[selectedZikrIndex].count >= goal {
            isGoalReached = true
        } else {
            isGoalReached = false
        }
    }
    
    private func saveCounts() {
        repository.save(zikrs: zikrs)
    }
        
    private func loadCounts() {
        repository.load(zikrs: &zikrs)
    }
    
}
