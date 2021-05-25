//
//  User.swift
//  Cuddly
//
//  Created by Haru on 2021/05/16.
//

import Foundation

struct User {
    
    static var currentUser: User?
    
    let username: String
    let email: String
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        
        self.username = dictionary[K.Firebase.username] as? String ?? ""
        self.email = dictionary[K.Firebase.email] as? String ?? ""
    }
}


