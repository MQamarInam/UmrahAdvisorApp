//
//  registerView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 06/08/2024.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var fullname: String = ""
    @State private var emailinput: String = ""
    @State private var passwordinput: String = ""
    @State private var confirmpasswordinput: String = ""
    
    @State private var fullnameError: String? = nil
    @State private var emailError: String? = nil
    @State private var passwordError: String? = nil
    @State private var confirmpasswordError: String? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    @State private var isSignedUp: Bool = false
    @State private var showResendOption = false
    
    var body: some View {
        ZStack {
//          Background Layer
            BackgroundSection
            
//          foreground layer
            VStack {
                Spacer()
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        
                        LogoSection
                        
                        NameSection
                        
                        EmailSection
                        
                        PasswordSection
                        
                        ConfirmPasswordSection
                        
                        ButtonSection
                        
                        ErrorMessageSection
                        
                    } // Vstack ends
                    
                    AlreadyAccHaveSection
                    
                } // Vstack ends
                .padding()
                .padding(.top, 32)
                .padding(.bottom)
                .background(.regularMaterial)
                .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isSignedUp) {
                LoginView()
            }
            
        } // Zstack ends
        .navigationBarHidden(true)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    private var BackgroundSection: some View {
        ZStack {
            LinearGradient(colors: [Color.background, Color.background, Color.bgcu], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            Image("loginbg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
        }
    }
    
    private var LogoSection: some View {
        Image("logoPng")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
            .padding(.top, -20)
            .padding(.bottom, 5)
    }
    
    private var NameSection: some View {
        VStack {
            TextField("Enter Full Name", text: $fullname)
                .padding(13)
                .font(.headline)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .autocapitalization(.words)
                .disableAutocorrection(true)
                .onChange(of: fullname) { oldValue, newValue in
                    fullnameError = newValue.isEmpty ? "Name cannot be empty" : nil
                }
            if let error = fullnameError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private var EmailSection: some View {
        VStack {
            TextField("Enter Email", text: $emailinput)
                .padding(13)
                .font(.headline)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .onChange(of: emailinput) { oldValue, newValue in
                    emailError = isValidEmail(newValue) ? nil : "Invalid Email"
                }
            if let error = emailError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private var PasswordSection: some View {
        VStack {
            SecureField("Enter Password", text: $passwordinput)
                .padding(13)
                .font(.headline)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .onChange(of: passwordinput) { oldValue, newValue in
                    passwordError = newValue.count < 6 ? "Password must be at least 6 characters" : nil
                }
            if let error = passwordError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private var ConfirmPasswordSection: some View {
        VStack {
            SecureField("Confirm Password", text: $confirmpasswordinput)
                .padding(13)
                .font(.headline)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .onChange(of: confirmpasswordinput) { oldValue, newValue in
                    confirmpasswordError = newValue != passwordinput ? "Password Should Match" : nil
                }
            if let error = confirmpasswordError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private var ButtonSection: some View {
        VStack {
            Button {
                authViewModel.signUp(email: emailinput, password: passwordinput, fullName: fullname)
                isSignedUp = false
                if authViewModel.errorMessage == nil {
                    isSignedUp = true
                    fullname = ""
                    emailinput = ""
                    passwordinput = ""
                    confirmpasswordinput = ""
                    fullnameError = nil
                    emailError = nil
                    passwordError = nil
                } else {
                    isSignedUp = false
                }
                
                if showResendOption {
                    authViewModel.resendEmailVerification()
                }
                
            } label: {
                Text("Register")
                    .foregroundColor(formIsValid ? Color.white : Color.white.opacity(0.7))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            }
            .background(formIsValid ? Color.background : Color.background.opacity(0.7))
            .disabled(!formIsValid)
            .cornerRadius(10)
        }
    }
    
    private var ErrorMessageSection: some View {
        VStack(spacing: 3) {
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(8)
                    .frame(height: 30)
                    .onAppear {
                        if authViewModel.errorMessage?.contains("Verification email sent. Please check your inbox.") ?? false {
                            showResendOption = true
                        }
                    }
            }
        }
    }
    
    private var AlreadyAccHaveSection: some View {
        HStack(spacing: 3) {
            Text("Already have an account.")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                authViewModel.errorMessage = nil
            }) {
                Text("Login")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.background)
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        RegisterView()
    }
}

extension RegisterView: AuthFormProtocol {
    
    var formIsValid: Bool {
        return !emailinput.isEmpty &&
        emailError == nil &&
        !fullname.isEmpty &&
        fullnameError == nil &&
        !passwordinput.isEmpty &&
        passwordError == nil &&
        passwordinput == confirmpasswordinput
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(
            pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        )
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
}
