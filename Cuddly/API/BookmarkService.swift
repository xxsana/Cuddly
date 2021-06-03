//
//  RecipeService.swift
//  Cuddly
//
//  Created by Haru on 2021/06/03.
//

import Foundation
import Firebase

struct BookmarkService {
    static let shared = BookmarkService()
    
    func uploadToBookmark(with id: String, completion: ()->()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = [K.Firebase.recipeID: id,
                      K.Firebase.timestamp: Int(NSDate().timeIntervalSince1970)] as [String : Any ]
        
        let ref = REF_USERS.child(uid).child("bookmarkItems").child("\(id)")
        ref.updateChildValues(values)
        
        completion()
    }
    
    func fetchBookmarks(completion: @escaping((String) -> Void)) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = REF_USERS.child(uid).child("bookmarkItems")
        ref.queryOrdered(byChild: K.Firebase.timestamp).observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let id = dictionary[K.Firebase.recipeID] as? String else { return }
            completion(id)
        }
    }
    
    func delete(_ id: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // find ref by id
        let ref = REF_USERS.child(uid).child("bookmarkItems").child(id)
        
        // delete
        ref.removeValue()
    }
}
