//
//  HadithServiceProtocol.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 25/11/2025.
//

import Foundation

protocol HadithServiceProtocol {
    func fetchRemoteHadiths() async throws -> [Hadith]
    func saveLocal(hadiths: [Hadith])
    func loadLocal() -> [Hadith]
}
