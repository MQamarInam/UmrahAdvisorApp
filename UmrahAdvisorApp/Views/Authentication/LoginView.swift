import SwiftUI

struct LoginView: View {
    
    @State var emailinput: String = ""
    @State var passwordinput: String = ""
    @State var showResetPasswordAlert: Bool = false
    @State var resetEmail: String = ""
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.background, Color.background, Color.bgcu], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                Image("loginbg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.1)
                
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
                            
                            TextField("Email Address", text: $emailinput)
                                .padding(13)
                                .font(.headline)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            SecureField("Password", text: $passwordinput)
                                .padding(13)
                                .font(.headline)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            
                            Button {
                                authViewModel.signIn(email: emailinput, password: passwordinput)
                            } label: {
                                if authViewModel.isLoading {
                                    ProgressView()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                } else {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(formIsValid ? Color.background : Color.background.opacity(0.5))
                                        .cornerRadius(10)
                                }
                            }
                            .disabled(authViewModel.isLoading || !formIsValid)
                            
                            HStack {
                                Button {
                                    showResetPasswordAlert.toggle()
                                } label: {
                                    Text("Forgot Password?")
                                        .font(.headline)
                                        .foregroundStyle(Color.red)
                                }
                                .padding(.leading, 10)
                                .alert("Reset Password", isPresented: $showResetPasswordAlert) {
                                    TextField("Enter your email", text: $resetEmail)
                                    Button("Send Reset Link") {
                                        authViewModel.forgotPassword(email: resetEmail)
                                    }
                                    Button("Cancel", role: .cancel) {}
                                } message: {
                                    Text("Enter your email address to receive a password reset link.")
                                }

                                Spacer()
                            }
                            
                            if let errorMessage2 = authViewModel.errorMessage {
                                Text(errorMessage2)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                        
                        HStack(spacing: 3) {
                            Text("Don't have an account.")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            NavigationLink("Register", destination: RegisterView())
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.background)
                        }
                        
                    }
                    .padding()
                    .padding(.top, 32)
                    .padding(.bottom)
                    .background(.regularMaterial)
                    .cornerRadius(20)
                    
                    Spacer()
                }
                .padding()
                .navigationDestination(isPresented: $authViewModel.isSignedIn) {
                    ContentView()
                }
                .navigationDestination(isPresented: $authViewModel.shouldNavigateToAdminView) {
//                    MainAdminPanelView()
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

#Preview {
    LoginView()
}

extension LoginView: AuthFormProtocol {
    var formIsValid: Bool {
        return !emailinput.isEmpty &&
        emailinput.contains("@") &&
        !passwordinput.isEmpty &&
        passwordinput.count > 5
    }
}
