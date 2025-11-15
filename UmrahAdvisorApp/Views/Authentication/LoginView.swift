import SwiftUI

struct LoginView: View {
    
    @State var emailinput: String = ""
    @State var passwordinput: String = ""
    @State var showResetPasswordAlert: Bool = false
    
    @State private var emailError: String? = nil
    @State private var passwordError: String? = nil
    
    @State var resetEmail: String = ""
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                BackgroundSection
                
                VStack {
                    Spacer()
                    VStack(spacing: 30) {
                        VStack(spacing: 15) {
                            
                            LogoSection
                            
                            EmailSection
                            
                            PasswordSection
                            
                            ButtonSection
                            
                            ForgotPasswordSection
                            
                            ErrorMessageSection
                        }
                        
                        DoNotHaveAccSection
                        
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
                    MainAdminPanelView()
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
        emailError == nil &&
        !passwordinput.isEmpty &&
        passwordError == nil
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(
            pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        )
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
}

extension LoginView  {
    
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
                    passwordError = passwordinput.count < 6 ? "Password must be at least 6 Characters" : nil
                }
            if let error = passwordError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private var ButtonSection: some View {
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
                    .foregroundColor(formIsValid ? Color.white : Color.white.opacity(0.7))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(formIsValid ? Color.background : Color.background.opacity(0.7))
                    .cornerRadius(10)
            }
        }
        .disabled(authViewModel.isLoading || !formIsValid)
    }
    
    private var ErrorMessageSection: some View {
        VStack {
            if let errorMessage2 = authViewModel.errorMessage {
                Text(errorMessage2)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding()
            }
        }
    }
    
    private var ForgotPasswordSection: some View {
        HStack {
            Button {
                showResetPasswordAlert.toggle()
            } label: {
                Text("Forgot Password?")
                    .font(.subheadline)
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
    }
    
    private var DoNotHaveAccSection: some View {
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
    
}
