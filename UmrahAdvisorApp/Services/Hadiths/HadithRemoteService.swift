//
//  HadithRemoteService.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 25/11/2025.
//

import Foundation

final class HadithRemoteService {
    
    private let urlString = "https://apiumrah.vercel.app/hadiths"
    
    func fetch() async throws -> [Hadith] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(HadithsResult.self, from: data)
        return decoded.hadiths
        
    }
    
}
