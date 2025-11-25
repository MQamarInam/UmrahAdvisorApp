//
//  TasbihCounterProtocol.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 25/11/2025.
//

import Foundation

protocol TasbihCounterProtocol {
    
    var zikrs: [Zikr] { get set }
    var selectedZikrIndex: Int { get set }
    var goal: Int { get set }
    var isGoalReached: Bool { get set }

    func incrementCounter()
    func resetCounter()
    func checkGoal()
    
}

protocol TasbihStorageServiceProtocol {
    func saveCounts(_ zikrs: [Zikr])
    func loadCounts(for zikrs: inout [Zikr])
}

protocol TasbihRepositoryProtocol {
    func save(zikrs: [Zikr])
    func load(zikrs: inout [Zikr])
}
