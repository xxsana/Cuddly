//
//  UserService.swift
//  Cuddly
//
//  Created by Haru on 2021/05/16.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // will user just one time
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            User.currentUser = user
            
        }
    }
    
    func uploadAddress(_ values: [String : Any], completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // save to firebase
        REF_USER_ADDRESS.child(uid).updateChildValues(values, withCompletionBlock: completion)
        
    }
    
    func fetchUserAddress() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // read user's address snapshot and send it to user defaults service
        REF_USER_ADDRESS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: String] else {return}
            UserDefaultsService.shared.saveAddress(dictionary)
        }
    }
}


