//
//  Cart.swift
//  Cuddly
//
//  Created by Haru on 2021/05/25.
//

import Foundation

struct Cart {
    static var sharedCart = [CartItem]() {
        didSet {
            print("DEBUG: add an item to cart.")
        }
    }
}

struct CartItem {
    
    let productID: String
    let count: Int
    let price: Int
    var selected: Bool = false
    
    init(dictionary: [String: Any]) {
        self.productID = dictionary["productID"] as? String ?? ""
        self.count = dictionary["count"] as? Int ?? 0
        self.price = dictionary["price"] as? Int ?? 0
    }
}
