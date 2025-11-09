import SwiftUI
import Firebase

struct ShowAllPackagesView: View {
    
    @State private var selectedPackage: Packages? = nil
    @State private var showDetailSheet = false
    @StateObject var fm: PackageViewModel = PackageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if fm.isLoading {
                    ProgressViewSection
                } else {
                    if fm.packages.isEmpty {
                        noPackagesSection
                    } else {
                        ListSection
                    }
                }
            }
            .navigationTitle("All Umrah Packages")
            .navigationBarTitleDisplayMode(.large)
//            .sheet(item: $selectedPackage) { package in
//                PackageDetailView(item: package)
//            }
            .onAppear {
                fm.fetchPackagesData()
            }
        }
    }
}

#Preview {
    ShowAllPackagesView()
}

extension ShowAllPackagesView {
    
    private var ProgressViewSection: some View {
        ProgressView("Loading Packages...")
            .progressViewStyle(CircularProgressViewStyle(tint: .green))
            .scaleEffect(1.5)
    }
    
    private var noPackagesSection: some View {
        Text("No packages found.")
            .foregroundColor(.gray)
            .font(.headline)
    }
    
    private var ListSection: some View {
        List(fm.packages) { package in
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
