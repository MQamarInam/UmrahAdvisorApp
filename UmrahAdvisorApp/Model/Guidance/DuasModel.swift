//
//  DuasModel.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 30/08/2025.
//

import Foundation

struct DuasResult: Codable {
    let duas: [Dua]
}

struct Dua: Codable, Identifiable {
    var id: Int {
        return Id
    }
    var Id: Int
    let name: String
    let text1: String
    let text2: String
}
