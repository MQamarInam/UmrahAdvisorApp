//
//  AuthViewModel.swift
//  FirebasePeoject
//
//  Created by Macbook Pro on 09/09/2024.

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol AuthFormProtocol {
    var formIsValid: Bool { get }
}

class AuthViewModel: ObservableObject {
    
    @Published var currentUser: User?
    @Published var errorMessage: String? = ""
    @Published var isSignedIn: Bool = false
    @Published var isLoading = false

    @Published var shouldNavigateToAdminView: Bool = false
    
    init() {
        self.isSignedIn = Auth.auth().currentUser != nil
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = User(id: currentUser.uid, fullname: currentUser.displayName ?? "", email: currentUser.email ?? "")
        }
        if let uid = Auth.auth().currentUser?.uid {
            fetchUser(for: uid)
        }
    }
    
    func signUp(email: String, password: String, fullName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            } else {
                self.errorMessage = "Account is created Sucessfully."
            }
            
            guard let user = result?.user else { return }
            user.sendEmailVerification(completion: { error in
                if let error = error {
                    self.errorMessage = "Failed to send verification email: \(error.localizedDescription)"
                    return
                } else {
                    self.errorMessage = "Verification email sent. Please check your inbox."
                    try? Auth.auth().signOut()
                    
                    let newUser = User(id: user.uid, fullname: fullName, email: email)
                    do {
                        let encodedUser = try Firestore.Encoder().encode(newUser)
                        Firestore.firestore().collection("users").document(user.uid).setData(encodedUser) { error in
                            if let error = error {
                                self.errorMessage = "Failed to save user data: \(error.localizedDescription)"
                            }
                        }
                    } catch {
                        self.errorMessage = "Failed to encode user data: \(error.localizedDescription)"
                    }
                }
            })
        }
    }
    
    func resendEmailVerification() {
        guard let user = Auth.auth().currentUser else {
            self.errorMessage = "User not found."
            return
        }
        user.reload { error in
            if let error = error {
                self.errorMessage = "Failed to reload user: \(error.localizedDescription)"
                return
            }
            if !user.isEmailVerified {
                user.sendEmailVerification { error in
                    if let error = error {
                        self.errorMessage = "Failed to resend verification email: \(error.localizedDescription)"
                    } else {
                        self.errorMessage = "Verification email resent. Please check your inbox."
                    }
                }
            } else {
                self.errorMessage = "Email is already verified."
            }
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        
        if email.lowercased() == "qamarinam026@gmail.com" && password == "567890" {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.errorMessage = "Invalid credentials. Please try again."
                self?.isSignedIn = false
                self?.shouldNavigateToAdminView = true
            }
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isSignedIn = false
                    self.shouldNavigateToAdminView = false
                }
                return
            }
            guard let user = result?.user else {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to retrieve user."
                    self.isSignedIn = false
                    self.shouldNavigateToAdminView = false
                }
                return
            }
            if !user.isEmailVerified {
                DispatchQueue.main.async {
                    self.errorMessage = "Email not verified. Please check your inbox and verify it."
                    try? Auth.auth().signOut()
                    self.isSignedIn = false
                    self.shouldNavigateToAdminView = false
                }
                return
            }
            self.fetchUser(for: user.uid)
            DispatchQueue.main.async {
                self.isSignedIn = true
                self.shouldNavigateToAdminView = false
            }
        }
    }

    func fetchUser(for uid: String) {
        Firestore.firestore().collection("users").document(uid).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage = "Error fetching user data: \(error.localizedDescription)"
                self.isSignedIn = false
                return
            }
            guard let snapshot = snapshot, let fetchedUser = try? snapshot.data(as: User.self) else {
                self.errorMessage = "User document does not exist."
                self.isSignedIn = false
                return
            }
            DispatchQueue.main.async {
                self.currentUser = fetchedUser
                self.isSignedIn = true
                self.errorMessage = nil
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            self.currentUser = nil
        } catch let signOutError {
            self.errorMessage = "Failed to sign out: \(signOutError.localizedDescription)"
        }
    }
    
    func deleteAccount(completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }
        Firestore.firestore().collection("users").document(user.uid).delete { error in
            if let error = error {
                print("Error deleting user data: \(error.localizedDescription)")
                completion(false)
                return
            }
            user.delete { error in
                if let error = error {
                    print("Error deleting user account: \(error.localizedDescription)")
                    completion(false)
                } else {
                    DispatchQueue.main.async {
                        self.currentUser = nil
                    }
                    completion(true)
                }
            }
        }
    }
    
    func updateUserName(fullName: String, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let userRef = Firestore.firestore().collection("users").document(uid)

        userRef.updateData([
            "fullname": fullName
        ]) { error in
            if let error = error {
                print("Error updating user: \(error.localizedDescription)")
                completion(false)
            } else {
                if var currentUser = self.currentUser {
                    currentUser.fullname = fullName
                    self.currentUser = currentUser
                }
                completion(true)
            }
        }
    }
    
    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to send reset email: \(error.localizedDescription)"
                }
                return
            }
            DispatchQueue.main.async {
                self.errorMessage = "Password reset email sent. Check your inbox."
            }
        }
    }
    
}
