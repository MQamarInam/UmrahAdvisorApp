//
//  TasbihStorageService.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 25/11/2025.
//

import Foundation

class TasbihStorageService: TasbihStorageServiceProtocol {
    
    private let storageKey = "zikrCounts"
    
    func saveCounts(_ zikrs: [Zikr]) {
        let dict = Dictionary(uniqueKeysWithValues: zikrs.map { ($0.name, $0.count) })
        UserDefaults.standard.set(dict, forKey: storageKey)
    }
    
    func loadCounts(for zikrs: inout [Zikr]) {
        if let savedCounts = UserDefaults.standard.dictionary(forKey: storageKey) as? [String: Int] {
            for i in zikrs.indices {
                zikrs[i].count = savedCounts[zikrs[i].name, default: 0]
            }
        }
    }
    
}
