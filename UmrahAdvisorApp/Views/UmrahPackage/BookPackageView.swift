//
//  BookPackageView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 18/09/2024.
//

import SwiftUI

struct BookPackageView: View {
    
    @State private var numberOfPackages = 1
    @State private var WhatsAppNumber = ""
    @State private var recipients: [RecipientDetail] = [RecipientDetail()]
    var item: Packages
    @State private var showAlert = false
    @State private var passportNumberError: String? = nil
    @State private var whatsappNumberError: String? = nil
    
    var totalPrice: Double {
        Double(numberOfPackages) * item.price
    }
    
    @StateObject var br: BookingViewModel = BookingViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    packageInfoSection
                    Divider()
                    packageQuantitySection
                    Divider()
                    recipientDetailsSection
                    
                    confirmBookingBTN
                    
                }
                .padding()
            }
            .alert("Booking Request Sent", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your booking request has been successfully sent.")
            }
        }
    }
}

#Preview {
    BookPackageView(item: Packages(
        id: "1",
        name: "Premium Umrah Package",
        price: 30000,
        days: 15,
        isHot: false,
        firstDays: 5,
        nextDays: 5,
        lastDays: 5,
        makkahHotel: "Hilton Makkah",
        madinahHotel: "Pullman Zamzam Madinah",
        roomTypes: "Private Room",
        transportType: "Private Transport",
        flightName: "Saudia Airlines",
        departure: FlightDetail(sector: "LHE-JED", date: ISO8601DateFormatter().date(from: "2024-12-01") ?? Date(), time: Date(), baggage: "30kg"),
        arrival: FlightDetail(sector: "JED-LHE", date: ISO8601DateFormatter().date(from: "2024-12-15") ?? Date(), time: Date(), baggage: "30kg")
    ))
}

extension BookPackageView {
    
    private var packageInfoSection: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("Booking for: \(item.name)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Price per Package: \(item.price, specifier: "%.1f") PKR")
                .font(.title2)
                .foregroundColor(.green)
            
            Text("Total Price: \(totalPrice, specifier: "%.1f") PKR")
                .font(.title2)
                .foregroundColor(.blue)
            
            Text("Duration: \(item.days) Days")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    private var packageQuantitySection: some View {
        Section(header: Text("Number of Packages").font(.title3).bold()) {
            Stepper(value: $numberOfPackages, in: 1...10, onEditingChanged: { _ in
                updateRecipientFields()
            }) {
                Text("Quantity: \(numberOfPackages)")
            }
            .tint(Color.background)
            
            TextField("WhatsApp Number", text: $WhatsAppNumber)
                .padding(12)
                .keyboardType(.numberPad)
                .background(Color.bgcu.opacity(0.3))
                .cornerRadius(10)
                .onChange(of: WhatsAppNumber) { oldValue, newValue in
                    whatsappNumberError = isValidContactNumber(newValue) ? nil : "Invalid WhatsApp Number"
                }
            if let error = whatsappNumberError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private var recipientDetailsSection: some View {
        Section(header: Text("Passport details of each recipient").font(.title3).bold()) {
            ForEach($recipients) { $recipient in
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recipient \(recipients.firstIndex(where: { $0.id == recipient.id })! + 1) Details")
                        .font(.headline)
                        .padding(.top, 5)
                    
                    Group {
                        TextField("Surname", text: $recipient.surName)
                        TextField("Given Names", text: $recipient.givenName)
                        TextField("Passport Number (e.g. BR1010101)", text: $recipient.passportNumber)
                            .onChange(of: recipient.passportNumber) { oldValue, newValue in
                                passportNumberError = isValidPassportNumber(newValue) ? nil : "Invalid Passport Number"
                            }
                            .textInputAutocapitalization(.characters)
                    }
                    .padding(12)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
                    if let error = passportNumberError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    DatePicker("Date of Birth", selection: $recipient.dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .bold()
                    
                    DatePicker("Date of Expiry", selection: $recipient.expiryDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .bold()
                }
                .padding()
                .background(Color.bgcu.opacity(0.4))
                .cornerRadius(10)
            }
        }
    }
    
    private func updateRecipientFields() {
        if recipients.count < numberOfPackages {
            for _ in recipients.count..<numberOfPackages {
                recipients.append(RecipientDetail())
            }
        } else if recipients.count > numberOfPackages {
            recipients.removeLast(recipients.count - numberOfPackages)
        }
    }
    
    private var isFormValid: Bool {
        for recipient in recipients {
            if recipient.surName.isEmpty || recipient.givenName.isEmpty || WhatsAppNumber.count < 11 {
                return false
            }
            if !isValidPassportNumber(recipient.passportNumber) {
                return false
            }
        }
        return true
    }

    private func isValidPassportNumber(_ passport: String) -> Bool {
        let pattern = "^[A-Z]{2}[0-9]{7}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: passport.utf16.count)
        return regex?.firstMatch(in: passport, options: [], range: range) != nil
    }
    
    private func isValidContactNumber(_ number: String) -> Bool {
        let pattern = "^(\\+92|0)3[0-9]{9}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: number.utf16.count)
        return regex?.firstMatch(in: number, options: [], range: range) != nil
    }
    
    private var confirmBookingBTN: some View {
        Button {
            _ = recipients.map { recipient in
                [
                    "surName": recipient.surName,
                    "givenName": recipient.givenName,
                    "passportNumber": recipient.passportNumber,
                    "dateOfBirth": recipient.dateOfBirth,
                    "expiryDate": recipient.expiryDate
                ]
            }
            br.saveBookingRequest(package: item, totalPrice: totalPrice, numberOfPackages: numberOfPackages, WhatsAppNumber: WhatsAppNumber, recipients: recipients
            )
            numberOfPackages = 1
            WhatsAppNumber = ""
            recipients = [RecipientDetail()]
            showAlert = true
        } label: {
            Text("Send Booking Request")
                .frame(maxWidth: .infinity)
                .padding(10)
                .font(.headline)
                .background(isFormValid ? Color.background : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(!isFormValid)
    }
    
}
