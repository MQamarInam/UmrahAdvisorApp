//
//  SendTransportationData.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 11/03/2025.
//

import SwiftUI

struct AddTransportationData: View {
    
    @StateObject private var vm: AddTransportationDataViewModel = AddTransportationDataViewModel()
    
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
                .navigationTitle("Add Tranportation")
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
}

#Preview {
    AddTransportationData()
}

extension AddTransportationData {
    
    private var contentSection: some View {
        VStack {
            Text("Add Transportation Information")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            Menu {
                Picker("Transportation Type", selection: $vm.transportationType) {
                    ForEach(vm.transportations, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
            } label: {
                HStack {
                    Text(vm.transportationType)
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
            
            TextField("Transportation Price", text: $vm.transportationPrice)
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
            if vm.transportationPrice.isEmpty {
                vm.alertMessage = "Please fill the Transportation Price field."
                vm.showAlert = true
            } else {
                vm.saveTransportationToFirebase()
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
            .background(Color.bgcu)
            .cornerRadius(10)
            .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal)
    }
    
}
