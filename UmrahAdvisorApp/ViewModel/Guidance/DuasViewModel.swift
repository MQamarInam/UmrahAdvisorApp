//
//  DuasViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 30/08/2025.
//

import Foundation

class DuasViewModel: ObservableObject {
    
    @Published var duaArray: [Dua] = []
    @Published var isLoading = false

    private let localStorageKey = "SavedDuas"

    @MainActor
    func fetchData() async {
        
        isLoading = true
        defer { isLoading = false }
        
        guard let url = URL(string: "https://apiumrah.vercel.app/duas") else {
            loadDuasFromLocal()
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = try JSONDecoder().decode(DuasResult.self, from: data)
            
            duaArray = decoder.duas
            saveDuasLocally(duas: decoder.duas)
            
        } catch {
            print("❌ Error fetching or decoding: \(error)")
            loadDuasFromLocal()
        }
    }

    private func saveDuasLocally(duas: [Dua]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(duas) {
            UserDefaults.standard.set(encoded, forKey: localStorageKey)
        }
    }

    private func loadDuasFromLocal() {
        if let savedDuas = UserDefaults.standard.data(forKey: localStorageKey) {
            let decoder = JSONDecoder()
            if let loadedDuas = try? decoder.decode([Dua].self, from: savedDuas) {
                duaArray = loadedDuas
            }
        }
    }
    
}
