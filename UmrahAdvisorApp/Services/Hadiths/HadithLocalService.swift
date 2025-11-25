//
//  HadithLocalService.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 25/11/2025.
//

import Foundation

final class HadithLocalService {
    
    private let key = "SavedHadiths"
    
    func save(_ hadith: [Hadith]) {
        if let encoded = try? JSONEncoder().encode(hadith) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load() -> [Hadith] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Hadith].self, from: data) else {
            return []
        }
        return decoded
    }
    
}
