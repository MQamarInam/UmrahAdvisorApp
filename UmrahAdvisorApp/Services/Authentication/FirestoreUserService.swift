//
//  UserDataServices.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 28/11/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class FirestoreUserService: UserProtocol  {
    
    private let db = Firestore.firestore()
    private let collection = "users"
    
    func saveUser(_ user: User, completion: @escaping (Result<Void, any Error>) -> Void) {
        do {
            let encoded = try Firestore.Encoder().encode(user)
            db.collection(collection).document(user.id).setData(encoded) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchUser(for uid: String, completion: @escaping (Result<User, any Error>) -> Void) {
        db.collection(collection).document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let snapshot = snapshot else {
                completion(.failure(NSError(domain: "NoSnapshot", code: -1)))
                return
            }
            do {
                let user = try snapshot.data(as: User.self)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func updateUserName(fullName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "NoUser", code: -1)))
            return
        }
        db.collection(collection).document(uid).updateData(["fullname": fullName]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
}
