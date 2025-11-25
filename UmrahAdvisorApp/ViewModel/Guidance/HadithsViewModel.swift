//
//  HadithsViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 31/08/2025.
//

import Foundation

@MainActor
class HadithsViewModel: ObservableObject {
    
    @Published var hadiths: [Hadith] = []
    @Published var isLoading = false
    
    private let repository: HadithServiceProtocol
    
    init(repository: HadithServiceProtocol = HadithRepository()) {
        self.repository = repository
    }
    
    func loadHadiths() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let remoteHadiths = try await repository.fetchRemoteHadiths()
            hadiths = remoteHadiths
            repository.saveLocal(hadiths: remoteHadiths)
            
        } catch {
            print("Fetching/decoding error: \(error.localizedDescription)")
            hadiths = repository.loadLocal()
        }
    }
    
}

