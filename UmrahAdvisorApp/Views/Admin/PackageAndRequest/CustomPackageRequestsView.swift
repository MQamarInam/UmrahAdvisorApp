//
//  CustomPackageRequestsView.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 16/03/2025.
//

import SwiftUI

struct CustomPackageRequestsView: View {
    
    @StateObject var viewModel = CustomPackageViewModel()
    @State private var showDeleteAlert = false
    @State private var requestToDelete: CustomPackageRequest? = nil
    @State private var showSuccessAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.customPackageRequests) { request in
                    ZStack {

                        NavigationLink(destination: CustomPackageRequestsDetailView(request: request)) {
                            VStack(alignment: .leading, spacing: 12) {

                                headerMobileSection(request: request)
                                totalPriceSection(request: request)
                                travelDateSection(request: request)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.bottom, 5)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color(.systemGray6))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            requestToDelete = request
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Package Requests")
            .background(Color(.systemGray6).ignoresSafeArea())
            .onAppear {
                viewModel.fetchCustomPackageRequestsData()
            }
            .alert("Delete Package Request", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {
                    requestToDelete = nil
                }
                Button("Delete", role: .destructive) {
                    if let request = requestToDelete {
                        viewModel.deleteRequest(request) { success in
                            if success {
                                showSuccessAlert = true
                            }
                        }
                    }
                }
            } message: {
                Text("Are you sure you want to delete this package request?")
            }
            .alert("Success", isPresented: $showSuccessAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Package request successfully deleted.")
            }
        }
    }
    
}

#Preview {
    CustomPackageRequestsView()
}

extension CustomPackageRequestsView {
    
    private func headerMobileSection(request: CustomPackageRequest) -> some View {
        HStack {
            Image(systemName: "phone.fill")
                .foregroundColor(.blue)
                .font(.system(size: 16))
            Text("Mobile: \(request.mobileNumber)")
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
    
    private func totalPriceSection(request: CustomPackageRequest) -> some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 16))
            Text("Total Price: \(request.grandTotalPrice, specifier: "%.1f")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private func travelDateSection(request: CustomPackageRequest) -> some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.orange)
                .font(.system(size: 16))
            Text("Travel Date: \(request.travelDate, format: .dateTime.day().month().year())")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
}
