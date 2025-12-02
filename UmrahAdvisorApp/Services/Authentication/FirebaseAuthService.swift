//
//  AuthServices.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 28/11/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseAuthService: AuthenticationProtocol {
    
    func signUp(email: String, password: String, fullName: String, completion: @escaping (Result<String, any Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "NoUser", code: -1)))
                return
            }
            user.sendEmailVerification { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(user.uid))
            }
        }
    }
    
    func resendEmailVerification(completion: @escaping (Result<Void, any Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "NoUser", code: -1)))
            return
        }
        user.reload { reloadError in
            if let reloadError = reloadError {
                completion(.failure(reloadError))
                return
            }
            if !user.isEmailVerified {
                user.sendEmailVerification { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } else {
                completion(.failure(NSError(domain: "AlreadyVerified", code: -1)))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<String, any Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "NoUser", code: -1)))
                return
            }
            if !user.isEmailVerified {
                completion(.failure(NSError(domain: "EmailNotVerified", code: -1)))
                return
            }
            completion(.success(user.uid))
        }
    }
    
    func signOut() -> Result<Void, any Error> {
        do {
            try Auth.auth().signOut()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "NoUser", code: -1)))
            return
        }

        user.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
}
