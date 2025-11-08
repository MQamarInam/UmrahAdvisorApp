//
//  HadithsModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 31/08/2025.
//

import Foundation

struct HadithsResult: Codable {
    let hadiths: [Hadith]
}

struct Hadith: Codable, Identifiable {
    var id: Int {
        return Id
    }
    var Id: Int
    let name: String
    let text: String
    let text2: String
    let text3: String
    let source: String?
}
