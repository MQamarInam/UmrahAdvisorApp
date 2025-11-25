//
//  DuaLocalService.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 24/11/2025.
//

import Foundation

final class DuaLocalService {
    
    private let key = "SavedDuas"

    func save(_ duas: [Dua]) {
        if let encoded = try? JSONEncoder().encode(duas) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func load() -> [Dua] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Dua].self, from: data) else {
            return []
        }
        return decoded
    }
    
}

