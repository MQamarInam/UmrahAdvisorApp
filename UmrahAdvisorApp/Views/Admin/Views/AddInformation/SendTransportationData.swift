//
//  SendTransportationData.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 11/03/2025.
//

import SwiftUI
import Firebase

struct SendTransportationData: View {
    
    @State private var transportationType: String = "Shared"
    @State private var transportationPrice: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let transportations = ["Shared", "Private"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Add Transportation Information")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        Menu {
                            Picker("Transportation Type", selection: $transportationType) {
                                ForEach(transportations, id: \.self) { type in
                                    Text(type).tag(type)
                                }
                            }
                        } label: {
                            HStack {
                                Text(transportationType)
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
                        
                        TextField("Transportation Price", text: $transportationPrice)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        Button(action: {
                            if transportationPrice.isEmpty {
                                alertMessage = "Please fill the Transportation Price field."
                                showAlert = true
                            } else {
                                saveTransportationToFirebase()
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Save Transportation to Firebase")
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
                }
                .padding(.vertical)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationTitle("Add Tranportation")
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
    }
    
    func saveTransportationToFirebase() {
        guard !transportationType.isEmpty else {
            alertMessage = "Please select a transportation type."
            showAlert = true
            return
        }
        guard let price = Double(transportationPrice) else {
            alertMessage = "Invalid price. Please enter a valid number."
            showAlert = true
            return
        }
        let db = Firestore.firestore()
        let transportationData: [String: Any] = [
            "type": transportationType,
            "price": price
        ]
        db.collection("Transportations").addDocument(data: transportationData) { error in
            if let error = error {
                alertMessage = "Error saving Transportation data: \(error.localizedDescription)"
                showAlert = true
            } else {
                alertMessage = "Transportation data saved successfully!"
                showAlert = true
                transportationType = "Shared"
                transportationPrice = ""
            }
        }
    }
    
}

#Preview {
    SendTransportationData()
}
