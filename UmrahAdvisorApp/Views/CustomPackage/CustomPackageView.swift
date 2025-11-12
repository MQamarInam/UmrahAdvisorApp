
import SwiftUI

struct CustomPackageView: View {
    
    @StateObject private var viewModel = CustomPackageViewModel()
    @State private var showPersonalInfoSheet = false
    
    var minimumDate: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    travelDateSection
                    flightSection
                    MakkahAndMadinahDaysSection
                    MakkahHotelSection
                    MadinahHotelSection
                    TransportSection
                    ZiyaratSection
                    TotalPriceSection
                    PersonalInformationBTNSection
                }
                .padding(.vertical)
            }
            .navigationTitle("Create Umrah Package")
            .sheet(isPresented: $showPersonalInfoSheet) {
                BookCustomPackageView(viewModel: viewModel)
            }
        }
        
    }
}

#Preview {
    CustomPackageView()
}

extension CustomPackageView {
    
    private var travelDateSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Select Travel Date")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            DatePicker("Departure Date", selection: $viewModel.travelDate, in: minimumDate..., displayedComponents: .date)
                .onChange(of: viewModel.travelDate) {_, _ in
                    viewModel.isDateSelected = true
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.5))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var flightSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Select Flight")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if viewModel.flights.isEmpty {
                Text("No flights available")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
            } else {
                Menu {
                    Picker("Flight", selection: $viewModel.selectedFlight) {
                        Text("None").tag(nil as Flight?)
                        ForEach(viewModel.flights, id: \.id) { flight in
                            Text(flight.name).tag(flight as Flight?)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedFlight?.name ?? "Select Flight")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
            }
            if let flight = viewModel.selectedFlight {
                Menu {
                    Picker("Duration", selection: $viewModel.selectedDuration) {
                        ForEach(flight.durations) { duration in
                            Text("\(duration.days) days - RS.\(duration.price, specifier: "%.1f")").tag(duration as FlightDuration?)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedDuration != nil ? "\(viewModel.selectedDuration!.days) days - RS.\(viewModel.selectedDuration!.price, specifier: "%.1f")" : "Select Duration")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
                .onChange(of: viewModel.selectedDuration) { oldValue, newValue in
                    viewModel.makkahDays = 0
                    viewModel.madinahDays = 0
                }
            }
            
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.5))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var MakkahAndMadinahDaysSection: some View {
        VStack {
            if let duration = viewModel.selectedDuration {
                let maxDays = duration.days
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Allocate Days")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    Stepper("Makkah Days: \(viewModel.makkahDays)", value: $viewModel.makkahDays, in: 0...maxDays)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .onChange(of: viewModel.makkahDays) { oldValue, newValue in
                            if viewModel.totalDays > maxDays {
                                viewModel.madinahDays = maxDays - viewModel.makkahDays
                            }
                        }
                    
                    Stepper("Madinah Days: \(viewModel.madinahDays)", value: $viewModel.madinahDays, in: 0...maxDays)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .onChange(of: viewModel.madinahDays) { oldValue, newValue in
                            if viewModel.totalDays > maxDays {
                                viewModel.makkahDays = maxDays - viewModel.madinahDays
                            }
                        }
                    
                    Text("Total Days: \(viewModel.totalDays) / \(maxDays)")
                        .foregroundColor(viewModel.totalDays == maxDays ? .orange : .red)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.bgcu.opacity(0.5))
                        .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal)
            } else {
                Text("Select a duration first")
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }
        }
    }
    
    private var MakkahHotelSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Select Makkah Hotel")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if viewModel.makkahHotels.isEmpty {
                Text("No hotels available")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
            } else {
                Menu {
                    Picker("Hotel", selection: $viewModel.selectedMakkahHotel) {
                        Text("None").tag(nil as Hotel?)
                        ForEach(viewModel.makkahHotels, id: \.id) { hotel in
                            Text(hotel.name).tag(hotel as Hotel?)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedMakkahHotel?.name ?? "Select Hotel")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
                .onChange(of: viewModel.selectedMakkahHotel) { oldValue, newValue in
                    viewModel.selectedMakkahRoom = nil
                }
            }
            if let makkahHotel = viewModel.selectedMakkahHotel {
                Menu {
                    Picker("Room Type", selection: $viewModel.selectedMakkahRoom) {
                        Text("None").tag(nil as Room?)
                        ForEach(makkahHotel.rooms, id: \.id) { room in
                            Text("\(room.type) - RS.\(room.price, specifier: "%.1f")").tag(room as Room?)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedMakkahRoom != nil ? "\(viewModel.selectedMakkahRoom!.type) - RS.\(viewModel.selectedMakkahRoom!.price, specifier: "%.1f")" : "Select Room Type")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
            }
            
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.5))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var MadinahHotelSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Select Madinah Hotel")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if viewModel.madinahHotels.isEmpty {
                Text("No hotels available")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
            } else {
                Menu {
                    Picker("Hotel", selection: $viewModel.selectedMadinahHotel) {
                        Text("None").tag(nil as Hotel?)
                        ForEach(viewModel.madinahHotels, id: \.id) { hotel in
                            Text(hotel.name).tag(hotel as Hotel?)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedMadinahHotel?.name ?? "Select Hotel")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
                .onChange(of: viewModel.selectedMadinahHotel) { oldValue, newValue in
                    viewModel.selectedMadinahRoom = nil
                }
            }
            if let madinahHotel = viewModel.selectedMadinahHotel {
                Menu {
                    Picker("Room Type", selection: $viewModel.selectedMadinahRoom) {
                        Text("None").tag(nil as Room?)
                        ForEach(madinahHotel.rooms, id: \.id) { room in
                            Text("\(room.type) - RS.\(room.price, specifier: "%.1f")").tag(room as Room?)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedMadinahRoom != nil ? "\(viewModel.selectedMadinahRoom!.type) - RS.\(viewModel.selectedMadinahRoom!.price, specifier: "%.1f")" : "Select Room Type")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
            }
            
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.5))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var TransportSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Select Transportation")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if viewModel.transportations.isEmpty {
                Text("No transportations available")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
            } else {
                TransportMenuSection
            }
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.5))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var TransportMenuSection: some View {
        Menu {
            Picker("Transportation", selection: $viewModel.selectedTransportation) {
                Text("None").tag(nil as Transportation?)
                ForEach(viewModel.transportations, id: \.id) { transport in
                    Text("\(transport.type) - RS.\(transport.price, specifier: "%.1f")").tag(transport as Transportation?)
                }
            }
        } label: {
            HStack {
                Text(viewModel.selectedTransportation != nil ? "\(viewModel.selectedTransportation!.type) - RS.\(viewModel.selectedTransportation!.price, specifier: "%.1f")" : "Select Transportation")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
    
    private var ZiyaratSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Select Ziyarat Locations")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if viewModel.ziyaratList.isEmpty {
                Text("No Ziyarat locations Available")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
            } else {
                ziyaratListSection
            }
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.5))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var ziyaratListSection: some View {
        ForEach(viewModel.ziyaratList) { ziyarat in
            HStack {
                Text("\(ziyarat.name)")
                Spacer()
                Text("RS.\(ziyarat.price, specifier: "%.1f")")
                Image(systemName: viewModel.selectedZiyarat.contains(ziyarat) ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
                    .padding(.leading, 5)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if viewModel.selectedZiyarat.contains(ziyarat) {
                    viewModel.selectedZiyarat.remove(ziyarat)
                } else {
                    viewModel.selectedZiyarat.insert(ziyarat)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
    
    private var TotalPriceSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Total Price")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            Text("RS.\(viewModel.totalPrice, specifier: "%.1f")")
                .font(.headline)
                .foregroundColor(.green)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.5))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var PersonalInformationBTNSection: some View {
        VStack {
            Button(action: {
                if !viewModel.isDateSelected {
                    viewModel.alertMessage = "Please select a Travel Date."
                    viewModel.showAlert = true
                } else if viewModel.selectedFlight == nil {
                    viewModel.alertMessage = "Please select a Flight before proceeding."
                    viewModel.showAlert = true
                } else if viewModel.selectedDuration == nil {
                    viewModel.alertMessage = "Please select a Flight duration."
                    viewModel.showAlert = true
                } else {
                    showPersonalInfoSheet = true
                }
            }) {
                Text("Proceed to Personal Information")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.bgcu)
                            .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .cornerRadius(6)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .padding(.horizontal)
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
}
