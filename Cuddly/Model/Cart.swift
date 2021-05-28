//
//  Cart.swift
//  Cuddly
//
//  Created by Haru on 2021/05/25.
//

import Foundation

struct Cart {
    static var sharedCart = [CartItem]()
}

struct CartItem {
    
    let productID: String
    let count: Int
    let price: Int
    var selected: Bool = false
    
    init(dictionary: [String: Any]) {
        self.productID = dictionary[K.Firebase.productID] as? String ?? ""
        self.count = dictionary[K.Firebase.count] as? Int ?? 0
        self.price = dictionary[K.Firebase.price] as? Int ?? 0
    }
}
