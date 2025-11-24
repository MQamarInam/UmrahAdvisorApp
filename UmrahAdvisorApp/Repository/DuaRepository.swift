//
//  DuaRepository.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 24/11/2025.
//

import Foundation

final class DuaRepository: DuaServiceProtocol {

    private let remote: DuaRemoteService
    private let local: DuaLocalService

    init(remote: DuaRemoteService = DuaRemoteService(),
         local: DuaLocalService = DuaLocalService()) {
        self.remote = remote
        self.local = local
    }

    func fetchRemoteDuas() async throws -> [Dua] {
        try await remote.fetch()
    }

    func saveLocal(duas: [Dua]) {
        local.save(duas)
    }

    func loadLocal() -> [Dua] {
        local.load()
    }
}
