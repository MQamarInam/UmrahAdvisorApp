//
//  HadithsViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 31/08/2025.
//

import Foundation

@MainActor
class HadithsViewModel: ObservableObject {
    
    @Published var HadithArray: [Hadith] = []
    @Published var isLoading = false
    
    private let localStorageKey = "SavedHadiths"
    
    func fetchData() async {
        
        isLoading = true
        defer { isLoading = false }
        
        guard let url = URL(string: "https://apiumrah.vercel.app/hadiths") else {
            loadHadithsFromLocal()
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = try JSONDecoder().decode(HadithsResult.self, from: data)
            
            HadithArray = decoder.hadiths
            saveHadithsLocally(hadiths: decoder.hadiths)
            
        } catch {
            print("Fetching/decoding error: \(error.localizedDescription)")
            loadHadithsFromLocal()
        }
    }
    
    private func saveHadithsLocally(hadiths: [Hadith]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(hadiths) {
            UserDefaults.standard.set(encoded, forKey: localStorageKey)
        }
    }
    
    private func loadHadithsFromLocal() {
        if let savedHadiths = UserDefaults.standard.data(forKey: localStorageKey) {
            let decoder = JSONDecoder()
            if let loadedHadiths = try? decoder.decode([Hadith].self, from: savedHadiths) {
                HadithArray = loadedHadiths
            }
        }
    }
    
}

