//
//  ProductService.swift
//  Cuddly
//
//  Created by Haru on 2021/05/23.
//

import Foundation
import Firebase

struct ProductService {
    
    static let shared = ProductService()

    
    func uploadToCart(productID: String, count: Int, price: Int, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = [K.Firebase.productID: productID,
                      K.Firebase.count: count,
                      K.Firebase.price: price] as [String : Any]
        
        
        // save to static value
        REF_USER_CART.child(uid).childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    
    }

    
    func fetchCart() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_CART.child(uid).observe(.childAdded) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            Cart.sharedCart.append(CartItem(dictionary: dictionary))
        }
    }
    
}
