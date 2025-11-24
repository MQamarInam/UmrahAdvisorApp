//
//  DuaServiceProtocol.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 24/11/2025.
//

import Foundation

protocol DuaServiceProtocol {
    func fetchRemoteDuas() async throws -> [Dua]
    func saveLocal(duas: [Dua])
    func loadLocal() -> [Dua]
}
