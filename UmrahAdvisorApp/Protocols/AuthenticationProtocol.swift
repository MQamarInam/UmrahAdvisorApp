//
//  AuthenticationProtocol.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 28/11/2025.
//

import Foundation

protocol AuthenticationProtocol {

    func signUp(email: String, password: String, fullName: String,
                completion: @escaping (Result<String, Error>) -> Void)

    func resendEmailVerification(completion: @escaping (Result<Void, Error>) -> Void)

    func signIn(email: String, password: String,
                completion: @escaping (Result<String, Error>) -> Void)

    func signOut() -> Result<Void, Error>

    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void)

    func forgotPassword(email: String,
                        completion: @escaping (Result<Void, Error>) -> Void)
}

protocol UserProtocol {

    func saveUser(_ user: User,
                  completion: @escaping (Result<Void, Error>) -> Void)

    func fetchUser(for uid: String,
                   completion: @escaping (Result<User, Error>) -> Void)

    func updateUserName(fullName: String,
                        completion: @escaping (Result<Void, Error>) -> Void)
}

protocol AuthFormProtocol {
    var formIsValid: Bool { get }
}
