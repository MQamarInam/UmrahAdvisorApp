import SwiftUI
import Firebase

struct ShowAllPackagesView: View {
    
    @State private var selectedPackage: Packages? = nil
    @State private var showDetailSheet = false
    @StateObject var fm: PackageViewModel = PackageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                categorySelectionSection

                if fm.isLoading {
                    ProgressViewSection
                } else {
                    if fm.filteredPackages.isEmpty {
                        noPackagesSection
                    } else {
                        ListSection
                    }
                }
            }
            .navigationTitle("Umrah Packages")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedPackage) { package in
                PackageDetailView(item: package)
            }
            .onAppear {
                fm.fetchPackages()
            }
        }
    }
}

#Preview {
    ShowAllPackagesView()
}

extension ShowAllPackagesView {
    
    private var categorySelectionSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(PackageCategory.allCases, id: \.self) { category in
                    categoryButton(for: category)
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
        }
    }
    
    private func categoryButton(for category: PackageCategory) -> some View {
        Text(category.rawValue)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(fm.selectedCategory == category ? Color.bgcu.opacity(0.8) : Color.gray.opacity(0.4))
            .foregroundColor(fm.selectedCategory == category ? .white : .anyBlackWhite.opacity(0.8))
            .cornerRadius(12)
            .onTapGesture {
                fm.selectedCategory = category
            }
    }
    
    private var ProgressViewSection: some View {
        ProgressView("Loading Packages...")
            .progressViewStyle(CircularProgressViewStyle(tint: .green))
            .scaleEffect(1.5)
    }
    
    private var noPackagesSection: some View {
        VStack {
            Spacer()
            Text("No packages found.")
                .foregroundColor(.gray)
                .font(.headline)
            Spacer()
        }
    }
    
    private var ListSection: some View {
        List(fm.filteredPackages) { package in
            Button(action: {
                selectedPackage = package
                showDetailSheet = true
            }) {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(package.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            VStack(alignment: .leading) {
                                Text("Duration: \(package.days) days")
                                Text("Price: \(package.price, specifier: "%.2f") PKR")
                            }
                            .font(.caption)
                            
                            Text("Itinerary")
                                .fontWeight(.medium)
                            VStack(alignment: .leading) {
                                Text("• First \(package.firstDays) days in Makkah")
                                Text("• Next \(package.nextDays) days in Madina")
                                Text("• Last \(package.lastDays) days back in Makkah")
                            }
                            .font(.caption)
                        }
                        
                        Spacer()
                        
                        Image("logoPng")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .opacity(0.1)
                            .padding(.trailing, 10)
                            .cornerRadius(30)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.black)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
            }
        }
        .listStyle(PlainListStyle())
    }
    
}
