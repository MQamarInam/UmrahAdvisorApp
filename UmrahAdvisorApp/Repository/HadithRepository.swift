//
//  HadithRepository.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 25/11/2025.
//

import Foundation

final class HadithRepository: HadithServiceProtocol {
    
    private let local: HadithLocalService
    private let remote: HadithRemoteService
    
    init(local: HadithLocalService = HadithLocalService(), remote: HadithRemoteService = HadithRemoteService()) {
        self.local = local
        self.remote = remote
    }
    
    func fetchRemoteHadiths() async throws -> [Hadith] {
        try await remote.fetch()
    }
    
    func saveLocal(hadiths hadith: [Hadith]) {
        local.save(hadith)
    }
    
    func loadLocal() -> [Hadith] {
        local.load()
    }
    
}
