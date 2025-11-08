//
//  registerView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 06/08/2024.
//

import SwiftUI

struct RegisterView: View {

    @State var emailinput: String = ""
    @State var fullname: String = ""
    @State var passwordinput: String = ""
    @State var confirmpasswordinput: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    @State var isSignedUp: Bool = false
    @State var showResendOption = false
    
    var body: some View {
        ZStack {
//          Background Layer
            LinearGradient(colors: [Color.background, Color.background, Color.bgcu], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            Image("loginbg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
            
//          foreground layer
            VStack {
                Spacer()
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        
                        Image("logoPng")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .padding(.top, -20)
                            .padding(.bottom, 5)
                        
                        TextField("Enter Full Name", text: $fullname)
                            .padding(13)
                            .font(.headline)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                        
                        TextField("Enter your valid Email", text: $emailinput)
                            .padding(13)
                            .font(.headline)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        SecureField("Password contain atleast 6 Characters", text: $passwordinput)
                            .padding(13)
                            .font(.headline)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        
                        SecureField("Confirm Password", text: $confirmpasswordinput)
                            .padding(13)
                            .font(.headline)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        
                        Button {
                            authViewModel.signUp(email: emailinput, password: passwordinput, fullName: fullname)
                            isSignedUp = false
                            if authViewModel.errorMessage?.contains("The email address is badly formatted.") ?? false {
                                isSignedUp = false
                            } else if authViewModel.errorMessage?.contains("The email address is already in use by another account.") ?? false {
                                isSignedUp = true
                            } else if authViewModel.errorMessage == nil {
                                isSignedUp = true
                                fullname = ""
                                emailinput = ""
                                passwordinput = ""
                                confirmpasswordinput = ""
                            } else {
                                isSignedUp = false
                            }
                            
                            if showResendOption {
                                authViewModel.resendEmailVerification()
                            }
                            
                        } label: {
                            Text("Register")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                        .background(formIsValid ? Color.background : Color.background.opacity(0.5))
                        .disabled(!formIsValid)
                        .cornerRadius(10)
                        
                        if let errorMessage = authViewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundStyle(.red)
                                .padding(8)
                                .onAppear {
                                    if authViewModel.errorMessage?.contains("Verification email sent. Please check your inbox.") ?? false {
                                        showResendOption = true
                                    }
                                }
                        }
                        
                    } // Vstack ends
                    
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
        .onAppear() {
            authViewModel.errorMessage = ""
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
        emailinput.contains("@") &&
        !fullname.isEmpty &&
        !passwordinput.isEmpty &&
        passwordinput.count > 5 &&
        passwordinput == confirmpasswordinput
    }
}
