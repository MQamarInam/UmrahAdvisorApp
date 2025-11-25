//
//  TasbihRepository.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 25/11/2025.
//

import Foundation

class TasbihRepository: TasbihRepositoryProtocol {
    
    private let storageService: TasbihStorageServiceProtocol
    
    init(storageService: TasbihStorageServiceProtocol = TasbihStorageService()) {
        self.storageService = storageService
    }
    
    func save(zikrs: [Zikr]) {
        storageService.saveCounts(zikrs)
    }
    
    func load(zikrs: inout [Zikr]) {
        storageService.loadCounts(for: &zikrs)
    }
    
}
