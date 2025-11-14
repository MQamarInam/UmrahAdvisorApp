import SwiftUI
import Firebase

struct FlightDetailView: View {
    
    let flight: Flight
    @ObservedObject var viewModel: CustomPackageViewModel
    
    @State private var showEditAlert = false
    @State private var newPrice: String = ""
    @State private var selectedDuration: FlightDuration?
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Available Durations:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(flight.durations, id: \.id) { duration in
                    VStack(spacing: 10) {
                        HStack {
                            Text("Days")
                            Spacer()
                            Text("\(duration.days)")
                            Spacer()
                        }
                        HStack {
                            Text("Price")
                            Spacer()
                            Text("Rs.\(duration.price, specifier: "%.1f")")
                            Spacer()
                            Button {
                                selectedDuration = duration
                                newPrice = "\(duration.price)"
                                showEditAlert = true
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .padding(.trailing, 10)
                                    .foregroundStyle(Color.blue)
                                    .font(.headline)
                            }
                        }
                    }
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.bgcu.opacity(0.6))
                    .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(flight.name)
            .alert("Edit Price", isPresented: $showEditAlert, presenting: selectedDuration) { duration in
                TextField("New Price", text: $newPrice)
                    .keyboardType(.decimalPad)
                Button("Save") {
                    if let newPriceValue = Double(newPrice), let flightId = flight.id, let durationId = duration.id {
                        viewModel.updateFlightDurationPrice(flightId: flightId, durationId: durationId, newPrice: newPriceValue)
                    }
                }
                Button("Cancel", role: .cancel) {
                    selectedDuration = nil
                }
            } message: { duration in
                Text("Enter the new price for \(duration.days) days.")
            }
        }
    }
}

#Preview {
    let viewModel = CustomPackageViewModel()
    return FlightDetailView(
        flight: Flight(
            id: "1",
            name: "Saudi Airlines",
            durations: [
                FlightDuration(id: "d1", days: 7, price: 1500.0),
                FlightDuration(id: "d2", days: 10, price: 2000.0)
            ]
        ),
        viewModel: viewModel
    )
}
