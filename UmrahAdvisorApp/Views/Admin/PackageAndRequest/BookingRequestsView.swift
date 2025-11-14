import SwiftUI
import FirebaseCore

struct BookingRequestsView: View {
    
    @StateObject var br: BookingViewModel = BookingViewModel()
    @State private var showDeleteAlert = false
    @State private var packageToDeleteIndex: IndexSet? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(br.bookingRequests) { booking in
                    BookingRow(booking: booking) {
                        if let index = br.bookingRequests.firstIndex(where: { $0.id == booking.id }) {
                            packageToDeleteIndex = IndexSet([index])
                            showDeleteAlert = true
                        }
                    }
                }
                .padding(.horizontal)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Booking Requests")
            .background(Color(.systemGray6).ignoresSafeArea())
            .onAppear {
                br.fetchBookingRequests()
            }
            .alert("Confirm Deletion", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {
                    packageToDeleteIndex = nil
                }
                Button("Delete", role: .destructive) {
                    if let index = packageToDeleteIndex {
                        br.deleteBookingRequest(at: index)
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
    BookingRequestsView()
}

struct BookingRow: View {
    
    var booking: BookingModel
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            NavigationLink(destination: BookingRequestDetailView(booking: booking)) {
                VStack(alignment: .leading, spacing: 12) {
                    
                    PackageName
                    Duration
                    PricePerPackage
                    TotalPrice
                    NumberOfPackages
                    
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
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

extension BookingRow {
    
    private var PackageName: some View {
        HStack {
            Image(systemName: "bag.fill")
                .foregroundColor(.blue)
                .font(.system(size: 16))
            Text("Booking for \(booking.packageName)")
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
    
    private var Duration: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.orange)
                .font(.system(size: 16))
            Text("Duration: \(booking.packageDays)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var PricePerPackage: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 16))
            Text("Price per Package: \(String(format: "%.1f", booking.packagePrice))")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var TotalPrice: some View {
        HStack {
            Image(systemName: "creditcard.fill")
                .foregroundColor(.purple)
                .font(.system(size: 16))
            Text("Total Price: \(String(format: "%.1f PKR", booking.totalPrice))")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var NumberOfPackages: some View {
        HStack {
            Image(systemName: "number.circle.fill")
                .foregroundColor(.red)
                .font(.system(size: 16))
            Text("Number of Packages: \(booking.numberOfPackages)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
}
