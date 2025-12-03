import Foundation
import Firebase
import FirebaseFirestore

class PackageViewModel: ObservableObject {
    
    @Published var packages: [Packages] = []
    @Published var isLoading = false
    @Published var selectedCategory: PackageCategory = .all
    
    var filteredPackages: [Packages] {
        switch selectedCategory {
        case .all:
            return packages
        case .hot:
            return packages.filter { $0.isHot }
        case .days28:
            return packages.filter { $0.days == 28 }
        case .days21:
            return packages.filter { $0.days == 21 }
        case .days14:
            return packages.filter { $0.days == 14 }
        case .days7:
            return packages.filter { $0.days == 7 }
        }
    }
    
    private let repository: PackageProtocol
    
    init(repository: PackageProtocol = PackageRepository()) {
        self.repository = repository
        fetchPackages()
    }
    
    func fetchPackages() {
        isLoading = true
        repository.fetchPackages { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let pkgs):
                    self.packages = pkgs
                case .failure(let error):
                    print("Failed to fetch packages: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func savePackage(_ package: Packages) {
        isLoading = true
        repository.savePackage(package) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                if case .success = result {
                    self.fetchPackages()
                }
            }
        }
    }
    
    func deletePackage(at offsets: IndexSet) {
        let ids = offsets.compactMap { packages[$0].id }
        for id in ids {
            repository.deletePackage(id: id) { _ in }
        }
        packages.remove(atOffsets: offsets)
    }
    
    func updatePrice(id: String, newPrice: Double) {
        repository.updatePackagePrice(id: id, newPrice: newPrice) { [weak self] result in
            if case .success = result {
                self?.fetchPackages()
            }
        }
    }
    
}
