import SwiftUI
import FirebaseCore

struct BookingRequestDetailView: View {
    
    var booking: BookingModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section
                SectionView(title: "Booking Details", icon: "bag.fill", color: .blue) {
                    DetailRow(icon: "bag.fill", label: "Package Name", value: booking.packageName)
                    DetailRow(icon: "calendar", label: "Duration", value: "\(booking.packageDays) Days")
                    DetailRow(icon: "dollarsign.circle.fill", label: "Price per Package", value: "\(String(format: "%.1f", booking.packagePrice)) PKR")
                    DetailRow(icon: "creditcard.fill", label: "Total Price", value: String(format: "%.1f PKR", booking.totalPrice))
                    DetailRow(icon: "number.circle.fill", label: "Number of Packages", value: "\(booking.numberOfPackages)")
                }
                
                // User Details Section
                SectionView(title: "User Details", icon: "person.fill", color: .green) {
                    DetailRow(icon: "envelope.fill", label: "User Email", value: booking.userEmail)
                    DetailRow(icon: "phone.fill", label: "Emergency Contact", value: booking.whatsAppNumber)
                }
                
                // Recipients Section
                if !booking.recipients.isEmpty {
                    SectionView(title: "Recipients", icon: "person.3.fill", color: .purple) {
                        ForEach(booking.recipients.indices, id: \.self) { index in
                            let recipient = booking.recipients[index]
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Recipient \(index + 1):")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                if let surName = recipient["surName"] as? String {
                                    DetailRow(icon: "person.fill", label: "Surname", value: surName)
                                }
                                if let givenName = recipient["givenName"] as? String {
                                    DetailRow(icon: "person.fill", label: "Given Name", value: givenName)
                                }
                                if let passportNumber = recipient["passportNumber"] as? String {
                                    DetailRow(icon: "doc.text.fill", label: "Passport Number", value: passportNumber)
                                }
                                if let dateOfBirth = recipient["dateOfBirth"] as? Timestamp {
                                    DetailRow(icon: "calendar", label: "Date of Birth", value: formatDate(dateOfBirth.dateValue()))
                                }
                                if let expiryDate = recipient["expiryDate"] as? Timestamp {
                                    DetailRow(icon: "calendar", label: "Expiry Date", value: formatDate(expiryDate.dateValue()))
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Booking Details")
        .background(Color(.systemGray6).ignoresSafeArea())
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct SectionView<Content: View>: View {
    var title: String
    var icon: String
    var color: Color
    let content: Content
    
    init(title: String, icon: String, color: Color, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 16))
                Text(title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
            }
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

struct DetailRow: View {
    var icon: String
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 14))
            Text(label)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    BookingRequestDetailView(
        booking: BookingModel(
            id: "sampleID",
            userId: "",
            userEmail: "test@example.com",
            packageName: "Silver Umrah Package",
            packagePrice: 350000,
            packageDays: 10,
            totalPrice: 700000,
            numberOfPackages: 2,
            whatsAppNumber: "0300-1234567",
            recipients: [
                [
                    "surName": "Khan",
                    "givenName": "Ahmad",
                    "passportNumber": "AB1234567",
                    "dateOfBirth": Timestamp(date: Date()),
                    "expiryDate": Timestamp(date: Date())
                ]
            ]
        )
    )
}

