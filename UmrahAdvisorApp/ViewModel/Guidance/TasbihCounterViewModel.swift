//
//  TasbihCounterViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 02/09/2025.
//

import Foundation
import SwiftUI

class TasbihCounterViewModel: ObservableObject {
    
    @Published var zikrs: [Zikr] = [
        Zikr(name: "Subhanallah"),
        Zikr(name: "Alhamdulillah"),
        Zikr(name: "Allahu Akbar")
    ]
    
    @Published var selectedZikrIndex: Int = 0
    @Published var goal: Int = 100
    @Published var isGoalReached: Bool = false
    
    private let storageKey = "zikrCounts"
    
    init() {
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
        let dict = Dictionary(uniqueKeysWithValues: zikrs.map { ($0.name, $0.count) })
        UserDefaults.standard.set(dict, forKey: storageKey)
    }
    
    private func loadCounts() {
        if let savedCounts = UserDefaults.standard.dictionary(forKey: storageKey) as? [String: Int] {
            for i in zikrs.indices {
                zikrs[i].count = savedCounts[zikrs[i].name, default: 0]
            }
        }
    }
    
}
