//
//  AuthViewModel.swift
//  FirebasePeoject
//
//  Created by Macbook Pro on 09/09/2024.

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    @Published var currentUser: User?
    @Published var errorMessage: String? = ""
    @Published var isSignedIn: Bool = false
    @Published var isLoading = false
    @Published var showResendVerificationOption = false 
    @Published var shouldNavigateToAdminView: Bool = false
    
    private let repository: AuthenticationRepository
    
    init(repository: AuthenticationRepository = AuthenticationRepository(
        authService: FirebaseAuthService(),
        userService: FirestoreUserService()
    )) {
        self.repository = repository
        self.isSignedIn = Auth.auth().currentUser != nil
        
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = User(
                id: currentUser.uid,
                fullname: currentUser.displayName ?? "",
                email: currentUser.email ?? ""
            )
            self.fetchUser(uid: currentUser.uid)
        }
    }
    
    func signUp(email: String, password: String, fullName: String) {
        isLoading = true
        repository.signUp(email: email, password: password, fullName: fullName) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let uid):
                    self?.errorMessage = "Verification email sent. Please check inbox."
                    
                    let user = User(id: uid, fullname: fullName, email: email)
                    self?.saveUserToFirestore(user)

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func saveUserToFirestore(_ user: User) {
        repository.saveUser(user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("User saved successfully")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func resendEmailVerification() {
        isLoading = true
        repository.resendEmailVerification { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.errorMessage = "Verification email resent. Please check your inbox."
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        if email.lowercased() == "qamarinam026@gmail.com" && password == "098765" {
            DispatchQueue.main.async {
                self.isLoading = false
                self.shouldNavigateToAdminView = true
            }
            return
        }
        repository.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let uid):
                    self?.fetchUser(uid: uid)
                case .failure(let error):
                    self?.isSignedIn = false
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchUser(uid: String) {
        repository.fetchUser(for: uid) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.currentUser = user
                    self?.isSignedIn = true

                case .failure(let error):
                    self?.isSignedIn = false
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func signOut() {
        switch repository.signOut() {
        case .success:
            self.currentUser = nil
            self.isSignedIn = false
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() {
        repository.deleteAccount { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.currentUser = nil
                    self?.isSignedIn = false

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func updateUserName(fullName: String, completion: @escaping (Bool) -> Void) {
        repository.updateUserName(fullName: fullName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.currentUser?.fullname = fullName
                    completion(true)

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    
    func forgotPassword(email: String) {
        repository.forgotPassword(email: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.errorMessage = "Reset email sent. Check inbox."

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
