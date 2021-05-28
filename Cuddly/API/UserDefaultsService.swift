//
//  UserDefaults.swift
//  Cuddly
//
//  Created by Haru on 2021/05/25.
//

import Foundation

struct UserDefaultsService {
    
    static let shared = UserDefaultsService()
    
    let defaults = UserDefaults.standard

    func saveAddress(_ dictionary: [String: String]) {
        defaults.set(dictionary, forKey: K.userAddress)
    }
    
    func fetchAddressFromUserDefaults() -> [String : String] {
        let dict = defaults.object(forKey: K.userAddress) as? [String : String] ??  [String : String]()
        
        return dict
    }
}
