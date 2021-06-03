//
//  AuthService.swift
//  Cuddly
//
//  Created by Haru on 2021/05/15.
//

import Foundation
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let username: String
}

struct AuthService {
    
    // instead of having to instantiate that service twice,
    // just create static instance - Sigleton
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func authenticateUser(completion: @escaping()->Void) {
        if Auth.auth().currentUser == nil {
            // User is NOT logged in
            // present Log in view controller
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    // completion is for using in controller class itself
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            
            // User registered successfully
            // unwrap unique id of user
            guard let uid = result?.user.uid else { return }
            
            let values = [K.Firebase.email: email, K.Firebase.username: username]
            
            REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
}
