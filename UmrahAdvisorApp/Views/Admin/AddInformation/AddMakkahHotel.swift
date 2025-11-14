import SwiftUI

struct AddMakkahHotel: View {
    
    @StateObject private var vm: AddMakkahHotelDataViewModel = AddMakkahHotelDataViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    hotelInfoSection
                    addRoomSection
                    addedRoomsSection
                    saveButton
                    
                }
                .padding(.vertical)
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text("Alert!"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationTitle("Add Makkah Hotel")
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
    }
    
}

#Preview {
    AddMakkahHotel()
}

extension AddMakkahHotel {
    
    private var hotelInfoSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Hotel Information")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            TextField("Hotel Name", text: $vm.hotelName)
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
    
    private var addRoomSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Add Room")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            // Enhanced Picker
            Menu {
                Picker("Room Type", selection: $vm.roomType) {
                    ForEach(vm.roomTypes, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
            } label: {
                HStack {
                    Text(vm.roomType)
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
            
            TextField("Room Price", text: $vm.roomPrice)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            addRoomBtn
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.bgcu.opacity(0.6))
                .shadow(color: Color.green.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var addRoomBtn: some View {
        Button(action: {
            if let price = Double(vm.roomPrice) {
                let room = Room(type: vm.roomType, price: price)
                vm.rooms.append(room)
                vm.roomPrice = ""
            } else {
                vm.alertMessage = "Invalid price. Please enter a valid number."
                vm.showAlert = true
            }
        }) {
            HStack {
                Spacer()
                Text("Add Room")
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
    
    private var addedRoomsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Added Rooms")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            ForEach(vm.rooms) { room in
                HStack {
                    Text("\(room.type)")
                        .foregroundColor(.primary)
                    Spacer()
                    Text("RS. \(room.price, specifier: "%.1f")")
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
                .fill(Color.bgcu.opacity(0.4))
                .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    private var saveButton: some View {
        Button(action: {
            if vm.hotelName.isEmpty || vm.rooms.isEmpty {
                vm.alertMessage = "Please fill all fields and add at least one room."
                vm.showAlert = true
            } else {
                vm.saveHotelToFirebase()
            }
        }) {
            HStack {
                Spacer()
                Text("Save to Firebase")
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
    
}
