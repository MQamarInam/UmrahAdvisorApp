import SwiftUI
import Firebase

struct AddPackageView: View {
    
    @StateObject private var dataVM = PackageCreationDataViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if dataVM.isLoading {
                    ProgressView("Loading data...")
                        .padding()
                } else {
                    VStack(spacing: 20) {
                        
                        packageInformationSection
                        
                        itinerarySection
                        
                        MakkahHotelSection
                        
                        MadinahHotelSection
                        
                        roomOptionsSection
                        
                        transportOptionsSection
                        
                        flightOptionsSection
                        
                        departureSection
                        
                        arrivalSection
                        
                        addPackageButton
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Add Umrah Package")
        }
    }
    
}

private extension View {
    func sectionStyle() -> some View {
        self.padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.bgcu.opacity(0.5))
                    .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal)
    }
    
    func datePickerStyle() -> some View {
        self.fontWeight(.regular)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal)
    }
}
struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
struct CustomMenu: View {
    @Binding var selection: String
    let options: [String]
    let placeholder: String
    
    var body: some View {
        Menu {
            Picker(placeholder, selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
        } label: {
            HStack {
                Text(selection.isEmpty ? placeholder : selection)
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

#Preview {
    AddPackageView()
}

extension AddPackageView {
    
    private var packageInformationSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Package Information")
            
            CustomTextField(placeholder: "Name", text: $dataVM.name)
            CustomTextField(placeholder: "Price", text: $dataVM.price, keyboardType: .decimalPad)
            CustomTextField(placeholder: "Duration (Days)", text: $dataVM.day, keyboardType: .numberPad)
            
            Toggle(isOn: $dataVM.isHot) {
                Text("Is Package deal Hot...")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
        }
        .sectionStyle()
    }
    
    private var itinerarySection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Itinerary")
            
            CustomTextField(placeholder: "Days in Makkah", text: $dataVM.firstdays, keyboardType: .numberPad)
            CustomTextField(placeholder: "Days in Madinah", text: $dataVM.nextdays, keyboardType: .numberPad)
            CustomTextField(placeholder: "Return to Makkah (Days)", text: $dataVM.lastdays, keyboardType: .numberPad)
        }
        .sectionStyle()
    }
    
    private var MakkahHotelSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Makkah Hotel")
            CustomMenu(selection: $dataVM.selectedMakkahHotel, options: dataVM.makkahHotels, placeholder: "Select Makkah Hotel")
        }
        .sectionStyle()
    }
    
    private var MadinahHotelSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(
                title: "Madinah Hotel"
            )
            CustomMenu(selection: $dataVM.selectedMadinahHotel, options: dataVM.madinahHotels, placeholder: "Select Madinah Hotel")
        }
        .sectionStyle()
    }
    
    private var roomOptionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Room Options")
            
            CustomMenu(selection: $dataVM.selectedRoomType, options: dataVM.roomOptions, placeholder: "Select Room Type")
        }
        .sectionStyle()
    }
    
    private var transportOptionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Transport Options")
            
            CustomMenu(selection: $dataVM.selectedTransport, options: dataVM.transportOptions, placeholder: "Select Transportation")
        }
        .sectionStyle()
    }
    
    private var flightOptionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Flight Options")
            
            CustomMenu(selection: $dataVM.selectedFlightName, options: dataVM.flightOptions, placeholder: "Select Airline")
        }
        .sectionStyle()
    }
    
    private var departureSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Departure Details")
            
            CustomMenu(selection: $dataVM.selectedDepartureSector, options: dataVM.departureSectorOptions, placeholder: "Select Sector")
            
            DatePicker("Select Date", selection: $dataVM.departureDate, displayedComponents: .date)
                .datePickerStyle()
            
            DatePicker("Select Time", selection: $dataVM.departureTime, displayedComponents: .hourAndMinute)
                .datePickerStyle()
            
            CustomTextField(placeholder: "Baggage", text: $dataVM.departureBaggage)
                .keyboardType(.numberPad)
        }
        .sectionStyle()
    }
    
    private var arrivalSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Arrival Details")
            
            CustomMenu(selection: $dataVM.selectedArrivalSector, options: dataVM.arrivalSectorOptions, placeholder: "Select Sector")
            
            DatePicker("Select Date", selection: $dataVM.arrivalDate, displayedComponents: .date)
                .datePickerStyle()
            
            DatePicker("Select Time", selection: $dataVM.arrivalTime, displayedComponents: .hourAndMinute)
                .datePickerStyle()
            
            CustomTextField(placeholder: "Baggage", text: $dataVM.arrivalBaggage)
                .keyboardType(.numberPad)
        }
        .sectionStyle()
    }
    
    private var addPackageButton: some View {
        Button {
            if dataVM.validatePackageData() {
                dataVM.addPackageAction()
                dataVM.alertMessage = "Package Added Successfully."
                dataVM.showAlert = true
            }
        } label: {
            Text("Add Package")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.bgcu)
                        .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
                )
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
        .alert(dataVM.alertMessage, isPresented: $dataVM.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
}
