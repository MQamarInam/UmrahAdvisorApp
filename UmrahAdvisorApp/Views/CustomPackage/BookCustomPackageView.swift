
import SwiftUI

struct BookCustomPackageView: View {
    
    @ObservedObject var viewModel: CustomPackageViewModel
    @State private var recipients: [RecipientDetails] = [RecipientDetails()]
    @State private var whatsAppNumber: String = ""
    @State private var passportNumberError: String? = nil
    @State private var whatsappNumberError: String? = nil
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isRequestSuccessful = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    headingSection
                    QantitySection
                    WhatsAppNumberSection
                    passportSection
                    submitButtonSection
                    
                }
                .padding()
            }
            .navigationTitle("Personal Information")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(isRequestSuccessful ? "Success" : "Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if isRequestSuccessful {
                            resetForm()
                        }
                    }
                )
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
}

#Preview {
    BookCustomPackageView(
        viewModel: CustomPackageViewModel()
    )
}

extension BookCustomPackageView {
    
    private var headingSection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Price per Package")
                    .font(.headline)
                Spacer()
                Text("\(viewModel.totalPrice, specifier: "%.1f")")
                    .font(.headline)
            }
            HStack {
                Text("Grand Total Price")
                    .font(.headline)
                Spacer()
                Text("\(viewModel.grandTotalPrice, specifier: "%.1f")")
                    .font(.headline)
            }
        }
    }
    
    private var QantitySection: some View {
        Stepper(value: $viewModel.numberOfPackages, in: 1...10, onEditingChanged: { _ in
            updateRecipientFields()
        }) {
            Text("Quantity: \(viewModel.numberOfPackages)")
                .bold()
        }
        .tint(Color.blue)
    }
        
    private var WhatsAppNumberSection: some View {
        Section {
            TextField("Whatsapp Number (11 digits)", text: $whatsAppNumber)
                .padding(.horizontal)
                .keyboardType(.numberPad)
                .padding(.vertical, 10)
                .background(Color.bgcu.opacity(0.4))
                .cornerRadius(10)
                .onChange(of: whatsAppNumber) { oldValue, newValue in
                    whatsappNumberError = isValidContactNumber(newValue) ? nil : "Invalid WhatsApp Number"
                }
            if let error = whatsappNumberError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        } header: {
            Text("Contact Information")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
            
    private var passportSection: some View {
        Section {
            ForEach($recipients) { $recipient in
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recipient \(recipients.firstIndex(where: { $0.id == recipient.id })! + 1) Details")
                        .font(.headline)
                        .padding(.top)
                    Group {
                        TextField("Surname", text: $recipient.surName)
                        
                        TextField("Given Name", text: $recipient.givenName)
                            
                        TextField("Passport Number (e.g., AB1234567)", text: $recipient.passportNumber)
                            .textInputAutocapitalization(.characters)
                            .onChange(of: recipient.passportNumber) { oldValue, newValue in
                                passportNumberError = isValidPassportNumber(newValue) ? nil : "Invalid Passport Number"
                            }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocorrectionDisabled(true)
                    
                    if let error = passportNumberError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Group {
                        DatePicker("Date of Birth", selection: $recipient.dateOfBirth, displayedComponents: .date)
                        
                        DatePicker("Passport Expiry Date", selection: $recipient.expiryDate, displayedComponents: .date)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.bgcu.opacity(0.5))
                .cornerRadius(10)
            }
        } header: {
            Text("Passport Details of each Participant")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var submitButtonSection: some View {
        Button {
            sendPackageRequest()
        } label: {
            Text("Submit Package Request")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(
                    isFormValid ? Color.bgcu :Color.gray
                )
                .cornerRadius(6)
        }
        .disabled(!isFormValid)
    }
    
    private func sendPackageRequest() {
        guard isFormValid else {
            alertMessage = "Please fill all fields correctly."
            showAlert = true
            return
        }
        let dateFormatter = ISO8601DateFormatter()
        let packageData: [String: Any] = [
            "numberOfPackages": viewModel.numberOfPackages,
            "whatsappNumber": whatsAppNumber,
            "recipients": recipients.map { recipient in
                [
                    "surname": recipient.surName,
                    "givenName": recipient.givenName,
                    "passportNumber": recipient.passportNumber,
                    "dateOfBirth": dateFormatter.string(from: recipient.dateOfBirth),
                    "expiryDate": dateFormatter.string(from: recipient.expiryDate)
                ]
            },
            "makkahHotel": viewModel.selectedMakkahHotel?.name ?? "",
            "madinahHotel": viewModel.selectedMadinahHotel?.name ?? "",
            "makkahRoom": viewModel.selectedMakkahRoom?.type ?? "",
            "madinahRoom": viewModel.selectedMadinahRoom?.type ?? "",
            "flight": viewModel.selectedFlight?.name ?? "",
            "duration": viewModel.selectedDuration?.days ?? 0,
            "transportation": viewModel.selectedTransportation?.type ?? "",
            "makkahDays": viewModel.makkahDays,
            "madinahDays": viewModel.madinahDays,
            "travelDate": dateFormatter.string(from: viewModel.travelDate),
            "ziyarat": viewModel.selectedZiyarat.map { $0.name },
            "totalPrice": viewModel.totalPrice,
            "grandTotalPrice": viewModel.grandTotalPrice
        ]
        viewModel.sendCustomPackageRequest(data: packageData) { success in
            if success {
                alertMessage = "Package request sent successfully!"
                isRequestSuccessful = true
            } else {
                alertMessage = "Failed to send package request. Please try again."
            }
            showAlert = true
        }
    }
    
    private func updateRecipientFields() {
        if recipients.count < viewModel.numberOfPackages {
            for _ in recipients.count..<viewModel.numberOfPackages {
                recipients.append(RecipientDetails())
            }
        } else if recipients.count > viewModel.numberOfPackages {
            recipients.removeLast(recipients.count - viewModel.numberOfPackages)
        }
    }
    
    private func resetForm() {
        viewModel.numberOfPackages = 1
        recipients = [RecipientDetails()]
        whatsAppNumber = ""
        isRequestSuccessful = false
    }
    
    private var isFormValid: Bool {
        guard !whatsAppNumber.isEmpty else {
            return false
        }
        for recipient in recipients {
            if recipient.surName.isEmpty || recipient.givenName.isEmpty || recipient.passportNumber.isEmpty {
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
    
}
