//
//  SendZiyaratData.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 11/03/2025.

import SwiftUI
import Firebase

struct SendZiyaratData: View {
    
    @State private var zyaratName: String = ""
    @State private var zyaratPrice: String = ""
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
                        Text("Add Ziyarat Information")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        TextField("Ziyarat Name", text: $zyaratName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        TextField("Ziyarat Price", text: $zyaratPrice)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        Button(action: {
                            if zyaratName.isEmpty || zyaratPrice.isEmpty {
                                alertMessage = "Please fill all fields for Ziyarat."
                                showAlert = true
                            } else {
                                saveZiyaratToFirebase()
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Save Ziyarat to Firebase")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
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
                .navigationTitle("Add Ziyarat")
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
    }
    
    func saveZiyaratToFirebase() {
        guard !zyaratName.isEmpty else {
            alertMessage = "Please enter a Ziyarat name."
            showAlert = true
            return
        }
        guard let price = Double(zyaratPrice) else {
            alertMessage = "Invalid price. Please enter a valid number."
            showAlert = true
            return
        }
        let db = Firestore.firestore()
        let ziyaratData: [String: Any] = [
            "name": zyaratName,
            "price": price
        ]
        db.collection("Ziyarats").addDocument(data: ziyaratData) { error in
            if let error = error {
                alertMessage = "Error saving Ziyarat data: \(error.localizedDescription)"
                showAlert = true
            } else {
                alertMessage = "Ziyarat data saved successfully!"
                showAlert = true
                zyaratName = ""
                zyaratPrice = ""
            }
        }
    }
    
}

#Preview {
    SendZiyaratData()
}
