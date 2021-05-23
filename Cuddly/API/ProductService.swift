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
    
    func uploadToCart(productID: String, count: Int, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "productId": productID,
                      "count": count] as [String : Any]
        
        REF_CART.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
}
