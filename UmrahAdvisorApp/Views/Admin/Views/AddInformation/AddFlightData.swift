import SwiftUI

struct AddFlightData: View {
    
    @StateObject private var vm: AddFlightDataViewModel = AddFlightDataViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    flightNameSection
                    flightDurationSection
                    addedDurationsSection
                    addButtonSection
                    
                }
                .padding(.vertical)
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text("Alert!"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationTitle("Add Flight Data")
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
}

#Preview {
    AddFlightData()
}

extension AddFlightData {
    
    private var flightNameSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Flight Information")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            TextField("Airline Name", text: $vm.flightName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.6))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var flightDurationSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Add Duration")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            // Enhanced Picker
            Menu {
                Picker("Flight Duration (Days)", selection: $vm.flightDuration) {
                    ForEach(vm.flightDurations, id: \.self) { duration in
                        Text("\(duration) days").tag(duration)
                    }
                }
            } label: {
                HStack {
                    Text("\(vm.flightDuration) days")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .padding(.horizontal)
            
            TextField("Flight Price", text: $vm.flightPrice)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            Button(action: {
                if let price = Double(vm.flightPrice) {
                    let duration = FlightDuration(days: vm.flightDuration, price: price)
                    vm.durations.append(duration)
                    vm.flightPrice = ""
                } else {
                    vm.alertMessage = "Invalid price. Please enter a valid number."
                    vm.showAlert = true
                }
            }) {
                HStack {
                    Spacer()
                    Text("Add Duration")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.bgcu)
                .cornerRadius(10)
                .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.6))
                .shadow(color: Color.green.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var addedDurationsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Added Durations")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            
            ForEach(vm.durations) { duration in
                HStack {
                    Text("\(duration.days) days")
                        .foregroundColor(.primary)
                    Spacer()
                    Text("RS. \(duration.price, specifier: "%.1f")")
                        .foregroundColor(.primary)
                }
                .padding()
                .background(Color(.systemGray6))
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.3))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var addButtonSection: some View {
        Button(action: {
            if vm.flightName.isEmpty || vm.durations.isEmpty {
                vm.alertMessage = "Please fill all fields and add at least one duration."
                vm.showAlert = true
            } else {
                vm.saveFlightToFirebase()
            }
        }) {
            Text("Save to Firebase")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.bgcu)
                .cornerRadius(10)
                .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal)
    }
    
}
