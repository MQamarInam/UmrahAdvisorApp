//
//  UserBookingRequestsView.swift
//  UltimateUmrahAdvisor
//
//  Created by Qaim's Macbook  on 10/05/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct UserBookingRequestsView: View {
    
    @StateObject var viewModel = BookingViewModel()
    @State private var showDeleteAlert = false
    @State private var packageToDeleteIndex: IndexSet? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.bookingRequests) { booking in
                    BookingRow(booking: booking) {
                        if let index = viewModel.bookingRequests.firstIndex(where: { $0.id == booking.id }) {
                            packageToDeleteIndex = IndexSet([index])
                            showDeleteAlert = true
                        }
                    }
                }
                .padding(.horizontal)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("My Bookings")
            .background(Color(.systemGray6).ignoresSafeArea())
            .onAppear {
                if let userId = Auth.auth().currentUser?.uid {
                    viewModel.fetchUserBookingRequests(userId: userId)
                }
            }
            .alert("Confirm Deletion", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {
                    packageToDeleteIndex = nil
                }
                Button("Delete", role: .destructive) {
                    if let index = packageToDeleteIndex {
                        viewModel.deleteBookingRequest(at: index)
                    }
                    packageToDeleteIndex = nil
                }
            } message: {
                Text("Are you sure you want to delete this Booking Request? This action cannot be undone.")
            }
        }
    }
}

#Preview {
    UserBookingRequestsView()
}
