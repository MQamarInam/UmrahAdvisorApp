//
//  DuaRemoteService.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 24/11/2025.
//

import Foundation

final class DuaRemoteService {
    private let urlString = "https://apiumrah.vercel.app/duas"
    
    func fetch() async throws -> [Dua] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(DuasResult.self, from: data)
        return decoded.duas
    }
}

