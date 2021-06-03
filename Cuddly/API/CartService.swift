//
//  ProductService.swift
//  Cuddly
//
//  Created by Haru on 2021/05/23.
//

import Foundation
import Firebase

struct CartService {
    
    static let shared = CartService()

    
    func uploadToCart(productID: String, count: Int, price: Int, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = [K.Firebase.productID: productID,
                      K.Firebase.count: count,
                      K.Firebase.price: price,
                      K.Firebase.timestamp: Int(NSDate().timeIntervalSince1970)] as [String : Any]
        
        let ref = REF_USERS.child(uid).child("cartItems").childByAutoId()
        ref.updateChildValues(values, withCompletionBlock: completion)
    
    }
    
    func fetchCart(completion: @escaping([String : Any]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = REF_USERS.child(uid).child("cartItems")
        ref.queryOrdered(byChild: K.Firebase.timestamp).observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            completion(dictionary)
        }
    }
}
