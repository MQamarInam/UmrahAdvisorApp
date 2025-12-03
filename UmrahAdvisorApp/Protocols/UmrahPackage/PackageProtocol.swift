//
//  BookingProtocol.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 02/12/2025.
//

import Foundation

protocol PackageProtocol {
    func savePackage(_ package: Packages, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchPackages(completion: @escaping (Result<[Packages], Error>) -> Void)
    func deletePackage(id: String, completion: @escaping (Result<Void, Error>) -> Void)
    func updatePackagePrice(id: String, newPrice: Double, completion: @escaping (Result<Void, Error>) -> Void)
}
