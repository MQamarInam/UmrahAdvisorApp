//
//  CustomPackageRequestsDetailView.swift
//  FirebasePeoject
//
//  Created by Qaim's Macbook  on 16/03/2025.
//

import SwiftUI

struct CustomPackageRequestsDetailView: View {
    
    var request: CustomPackageRequest
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    
                    headerPhone
                    packagesSection
                    grandTotal
                    travelDate
                    
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                
                hotelsSection
                flightTransportation
                ziyaratSection
                recipientSection
                
            }
            .padding()
        }
        .navigationTitle("Package Details")
        .background(Color(.systemGray6).ignoresSafeArea())
        
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
}

#Preview {
    let sampleRequest = CustomPackageRequest(
        id: "12345",
        numberOfPackages: 2,
        mobileNumber: "1234567890",
        recipients: [
            [
                "surname": "Doe",
                "givenName": "John",
                "passportNumber": "AB1234567",
                "dateOfBirth": Date(),
                "expiryDate": Date().addingTimeInterval(60 * 60 * 24 * 365 * 5)
            ],
            [
                "surname": "Doe",
                "givenName": "Jane",
                "passportNumber": "CD9876543",
                "dateOfBirth": Date(),
                "expiryDate": Date().addingTimeInterval(60 * 60 * 24 * 365 * 5)
            ]
        ],
        makkahHotel: "Makkah Royal Hotel",
        madinahHotel: "Madinah Royal Hotel",
        makkahRoom: "Single Room",
        madinahRoom: "Double Room",
        flight: "Saudi Airlines",
        duration: 7,
        transportation: "Bus",
        makkahDays: 4,
        madinahDays: 3,
        travelDate: Date(),
        ziyarat: ["Masjid al-Haram", "Masjid an-Nabawi"],
        totalPrice: 5000.0,
        grandTotalPrice: 10000.0
    )
    return CustomPackageRequestsDetailView(request: sampleRequest)
}

extension CustomPackageRequestsDetailView {
    
    private var headerPhone: some View {
        HStack {
            Image(systemName: "phone.fill")
                .foregroundColor(.blue)
                .font(.system(size: 16))
            Text("Mobile: \(request.mobileNumber)")
                .font(.headline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var packagesSection: some View {
        HStack {
            Image(systemName: "shippingbox.fill")
                .foregroundColor(.green)
                .font(.system(size: 16))
            Text("Packages: \(request.numberOfPackages)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var grandTotal: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .foregroundColor(.purple)
                .font(.system(size: 16))
            Text("Grand Total: \(request.grandTotalPrice, specifier: "%.1f")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var travelDate: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.orange)
                .font(.system(size: 16))
            Text("Travel Date: \(request.travelDate, format: .dateTime.day().month().year())")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var hotelsSection: some View {
        SectionViews(title: "Hotels", icon: "house.fill", color: .blue) {
            DetailRows(icon: "mappin.circle.fill", label: "Makkah Hotel", value: request.makkahHotel)
            DetailRows(icon: "mappin.circle.fill", label: "Madinah Hotel", value: request.madinahHotel)
            DetailRows(icon: "bed.double.fill", label: "Makkah Room", value: request.makkahRoom)
            DetailRows(icon: "bed.double.fill", label: "Madinah Room", value: request.madinahRoom)
        }
    }
    
    private var flightTransportation: some View {
        SectionViews(title: "Flight & Transportation", icon: "airplane", color: .green) {
            DetailRows(icon: "airplane.circle.fill", label: "Flight", value: request.flight)
            DetailRows(icon: "clock.fill", label: "Duration", value: "\(request.duration) days")
            DetailRows(icon: "car.fill", label: "Transportation", value: request.transportation)
        }
    }
    
    private var ziyaratSection: some View {
        SectionViews(title: "Ziyarat", icon: "map.fill", color: .orange) {
            ForEach(request.ziyarat, id: \.self) { ziyarat in
                DetailRows(icon: "mappin.circle.fill", label: "Ziyarat", value: ziyarat)
            }
        }
    }
    
    private var recipientSection: some View {
        SectionViews(title: "Recipients", icon: "person.3.fill", color: .purple) {
            ForEach(request.identifiableRecipients) { recipient in
                VStack(alignment: .leading, spacing: 8) {
                    DetailRows(icon: "person.fill", label: "Surname", value: recipient.surName)
                    DetailRows(icon: "person.fill", label: "Given Name", value: recipient.givenName)
                    DetailRows(icon: "doc.text.fill", label: "Passport Number", value: recipient.passportNumber)
                    DetailRows(icon: "calendar", label: "Date of Birth", value: formatDate(recipient.dateOfBirth))
                    DetailRows(icon: "calendar", label: "Expiry Date", value: formatDate(recipient.expiryDate))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
    }
    
}

struct SectionViews<Content: View>: View {
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

struct DetailRows: View {
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
