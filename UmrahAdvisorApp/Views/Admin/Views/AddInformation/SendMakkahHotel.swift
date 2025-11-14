import SwiftUI
import Firebase

struct SendMakkahHotel: View {
    
    @State private var hotelName: String = ""
    @State private var roomType: String = "Single Bed"
    @State private var roomPrice: String = ""
    @State private var rooms: [Room] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    let roomTypes = ["Single Bed", "Double Bed", "Quad Bed", "Shared"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Hotel Information Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Hotel Information")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        TextField("Hotel Name", text: $hotelName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                    
                    // Add Room Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Add Room")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        // Enhanced Picker
                        Menu {
                            Picker("Room Type", selection: $roomType) {
                                ForEach(roomTypes, id: \.self) { type in
                                    Text(type).tag(type)
                                }
                            }
                        } label: {
                            HStack {
                                Text(roomType)
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
                        
                        TextField("Room Price", text: $roomPrice)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        Button(action: {
                            if let price = Double(roomPrice) {
                                let room = Room(type: roomType, price: price)
                                rooms.append(room)
                                roomPrice = ""
                            } else {
                                alertMessage = "Invalid price. Please enter a valid number."
                                showAlert = true
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
                            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                            .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: Color.green.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                    
                    // Added Rooms Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Added Rooms")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ForEach(rooms) { room in
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
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: Color.blue.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                    
                    // Save to Firebase Button
                    Button(action: {
                        if hotelName.isEmpty || rooms.isEmpty {
                            alertMessage = "Please fill all fields and add at least one room."
                            showAlert = true
                        } else {
                            saveHotelToFirebase()
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
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationTitle("Add Makkah Hotel")
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
    }
    
    func saveHotelToFirebase() {
        guard !hotelName.isEmpty else {
            alertMessage = "Please enter a hotel name."
            showAlert = true
            return
        }
        guard !rooms.isEmpty else {
            alertMessage = "Please add at least one room."
            showAlert = true
            return
        }
        let db = Firestore.firestore()
        let hotelData: [String: Any] = [
            "name": hotelName,
            "rooms": rooms.map { ["type": $0.type, "price": $0.price] }
        ]
        db.collection("MakkahHotels").addDocument(data: hotelData) { error in
            if let error = error {
                alertMessage = "Error saving data: \(error.localizedDescription)"
                showAlert = true
            } else {
                alertMessage = "Hotel data saved successfully!"
                showAlert = true
                hotelName = ""
                rooms = []
            }
        }
    }
    
}

#Preview {
    SendMakkahHotel()
}
