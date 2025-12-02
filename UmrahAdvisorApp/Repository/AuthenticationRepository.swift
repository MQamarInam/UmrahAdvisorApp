//
//  AuthenticationRepository.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 28/11/2025.
//

import Foundation

final class AuthenticationRepository {
    
    let authService: AuthenticationProtocol
    let userService: UserProtocol
    
    init(authService: AuthenticationProtocol, userService: UserProtocol) {
        self.authService = authService
        self.userService = userService
    }
    
    func saveUser(_ user: User, completion: @escaping (Result<Void, any Error>) -> Void) {
        userService.saveUser(user, completion: completion)
    }
    
    func fetchUser(for uid: String, completion: @escaping (Result<User, any Error>) -> Void) {
        userService.fetchUser(for: uid, completion: completion)
    }
    
    func updateUserName(fullName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        userService.updateUserName(fullName: fullName, completion: completion)
    }
    
    func signUp(email: String, password: String, fullName: String, completion: @escaping (Result<String, any Error>) -> Void) {
        authService.signUp(email: email, password: password, fullName: fullName, completion: completion)
    }
    
    func resendEmailVerification(completion: @escaping (Result<Void, any Error>) -> Void) {
        authService.resendEmailVerification(completion: completion)
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<String, any Error>) -> Void) {
        authService.signIn(email: email, password: password, completion: completion)
    }
    
    func signOut() -> Result<Void, any Error> {
        authService.signOut()
    }
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        authService.deleteAccount(completion: completion)
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        authService.forgotPassword(email: email, completion: completion)
    }
    
}
