import SwiftUI
import Firebase

struct DeletePackageView: View {
    
    @StateObject var pvm: PackageViewModel = PackageViewModel()
    @State private var selectedPackage: Packages? = nil
    @State private var showDeleteAlert = false
    @State private var showEditAlert = false
    @State private var packageToDeleteIndex: IndexSet? = nil
    @State private var newPrice: String = ""
    
    var body: some View {
        List {
            ForEach(pvm.packages) { package in
                packageRow(for: package)
            }
            .onDelete { offsets in
                packageToDeleteIndex = offsets
                showDeleteAlert = true
            }
        }
        .listStyle(PlainListStyle())
        .alert("Confirm Deletion", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {
                packageToDeleteIndex = nil
            }
            Button("Delete", role: .destructive) {
                if let index = packageToDeleteIndex {
                    pvm.deletePackage(at: index)
                }
                packageToDeleteIndex = nil
            }
        } message: {
            Text("Are you sure you want to delete this package? This action cannot be undone.")
        }
        .alert("Edit Price", isPresented: $showEditAlert, presenting: selectedPackage) { package in
            TextField("New Price", text: $newPrice)
                .keyboardType(.decimalPad)
            Button("Save") {
                if let newPriceValue = Double(newPrice), let packageId = package.id {
                    pvm.updatePrice(id: packageId, newPrice: newPriceValue)
                }
            }
            Button("Cancel", role: .cancel) {
                selectedPackage = nil
            }
        } message: { package in
            Text("Enter the new price for \(package.name).")
        }
    }
}


#Preview {
    DeletePackageView()
}

extension DeletePackageView {
    
    private func packageRow(for package: Packages) -> some View {
        VStack(alignment: .leading) {
            HStack {
                packageInfoSection(for: package)
                Spacer()
                imagesection
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.bgcu.opacity(0.3))
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
    }
    
    private func packageInfoSection(for package: Packages) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(package.name)
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading) {
                Text("Duration: \(package.days) days")
                HStack(alignment: .center) {
                    Text("Price: \(package.price, specifier: "%.2f") PKR")
                    Image(systemName: "square.and.pencil")
                        .padding(.horizontal,5)
                        .foregroundStyle(Color.blue)
                        .font(.subheadline)
                        .offset(x: -5)
                        .onTapGesture {
                            selectedPackage = package
                            newPrice = "\(package.price)"
                            showEditAlert = true
                        }
                }
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
    }
    
    private var imagesection: some View {
        Image("logoPng")
            .resizable()
            .scaledToFit()
            .frame(width: 140, height: 140)
            .opacity(0.1)
            .padding(.trailing, 10)
            .cornerRadius(30)
    }
    
}

