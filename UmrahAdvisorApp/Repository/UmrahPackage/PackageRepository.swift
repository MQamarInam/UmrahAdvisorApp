//
//  PackageRepository.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 02/12/2025.
//

import Foundation

class PackageRepository: PackageProtocol {
    
    private let service: PackageProtocol
        
    init(service: PackageProtocol = PackageService()) {
        self.service = service
    }
    
    func savePackage(_ package: Packages, completion: @escaping (Result<Void, Error>) -> Void) {
        service.savePackage(package, completion: completion)
    }
    
    func fetchPackages(completion: @escaping (Result<[Packages], Error>) -> Void) {
        service.fetchPackages(completion: completion)
    }
    
    func deletePackage(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        service.deletePackage(id: id, completion: completion)
    }
    
    func updatePackagePrice(id: String, newPrice: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        service.updatePackagePrice(id: id, newPrice: newPrice, completion: completion)
    }
    
}
