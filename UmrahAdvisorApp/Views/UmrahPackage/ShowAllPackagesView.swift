import SwiftUI
import Firebase

struct ShowAllPackagesView: View {
    
    @State private var selectedPackage: Packages? = nil
    @State private var showDetailSheet = false
    @StateObject var fm: PackageViewModel = PackageViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if fm.isLoading {
                    ProgressView("Loading Packages...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .scaleEffect(1.5)
                } else {
                    if fm.packages.isEmpty {
                        Text("No packages found.")
                            .foregroundColor(.gray)
                            .font(.headline)
                    } else {
                        List(fm.packages) { package in
                            Button(action: {
                                selectedPackage = package
                                showDetailSheet = true
                            }) {
                                VStack(alignment: .leading) {
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(package.name)
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                            
                                            Text("Duration: \(package.days) days")
                                            Text("Price: \(package.price, specifier: "%.2f") PKR")
                                            
                                            Text("Itinerary:")
                                                .fontWeight(.medium)
                                            Text("• First \(package.firstDays) days in Makkah")
                                            Text("• Next \(package.nextDays) days in Madina")
                                            Text("• Last \(package.lastDays) days back in Makkah")
                                        }
                                        
                                        Spacer()
                                        
                                        Image("hajjbg")
                                            .resizable()
                                            .frame(width: 90, height: 90)
                                            .cornerRadius(30)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationTitle("All Umrah Packages")
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
