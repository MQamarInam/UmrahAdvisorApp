//
//  DuasViewModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 30/08/2025.
//

import Foundation

@MainActor
final class DuasViewModel: ObservableObject {
    
    @Published var duas: [Dua] = []
    @Published var isLoading = false

    private let repository: DuaServiceProtocol

    init(repository: DuaServiceProtocol = DuaRepository()) {
        self.repository = repository
    }
    
    func loadDuas() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let remoteDuas = try await repository.fetchRemoteDuas()
            duas = remoteDuas
            repository.saveLocal(duas: remoteDuas)
        } catch {
            print("⚠️ Failed remote fetch: loading local cache")
            duas = repository.loadLocal()
        }
    }
}

