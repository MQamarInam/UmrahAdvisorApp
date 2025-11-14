//
//  SendZiyaratData.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 11/03/2025.

import SwiftUI

struct AddZiyaratData: View {
    
    @StateObject private var vm: AddZiyaratDataViewModel = AddZiyaratDataViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 15) {
                        
                        contentSection
                        saveBtn
                        
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.bgcu.opacity(0.6))
                            .shadow(color: Color.green.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text("Alert!"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationTitle("Add Ziyarat")
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
}

#Preview {
    AddZiyaratData()
}

extension AddZiyaratData {
    
    private var contentSection: some View {
        VStack {
            Text("Add Ziyarat Information")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            TextField("Ziyarat Name", text: $vm.zyaratName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            TextField("Ziyarat Price", text: $vm.zyaratPrice)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
    
    private var saveBtn: some View {
        Button(action: {
            if vm.zyaratName.isEmpty || vm.zyaratPrice.isEmpty {
                vm.alertMessage = "Please fill all fields for Ziyarat."
                vm.showAlert = true
            } else {
                vm.saveZiyaratToFirebase()
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
            .background(Color.bgcu)
            .cornerRadius(10)
            .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal)
    }
    
}
