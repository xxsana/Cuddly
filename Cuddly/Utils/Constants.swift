//
//  Constants.swift
//  Cuddly
//
//  Created by Haru on 2021/05/12.
//

import Foundation
import Firebase

// Property to access Database
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")


struct K {
    
    // custom color name in Assets
    static let lightYellowGreen = "LightYellowGreen"

    // fonts
    static let appleSDGothicNeo_Medium = "AppleSDGothicNeo-Medium"
    static let appleSDGothicNeo_SemiBold = "AppleSDGothicNeo-SemiBold"
    static let appleSDGothicNeo_Bold = "AppleSDGothicNeo-Bold"
    static let SFProDisplay_Semibold = "SFProDisplay-Semibold"
    static let SFProDisplay_Heavy = "SFProDisplay-Heavy"
    
    // icon name
    static let emptyCircle = "circle"
    static let checkedCircle = "checkmark.circle.fill"
    
    static let userAddress = "user_address"
    
    
    // view controller identifier
    struct id {
        static let recipeStepVC = "RecipeStepViewController"
        static let recipeMainVC = "RecipeMainViewController"
        static let recipeStepCell = "StepCell"
        static let recipeListCell = "RecipeListCell"
        static let navigation = "NavigationController"
        static let customTabBar = "CustomTabBarController"
        static let logInVC = "LogInViewController"
        static let userNavigation = "UserNav"
        static let userCell = "UserCell"
        static let productListCell = "ProductListCell"
        static let productMainVC = "ProductMainViewController"
        static let productImageCell = "ProductImageCell"
        static let cartVC = "CartViewController"
        static let cartCell = "CartCell"
        static let orderVC = "OrderViewController"
    }
    
    struct Firebase {
        static let email = "email"
        static let username = "userName"
        
        static let realName = "realName"
        static let phoneNumber = "phoneNumber"
        static let basicAddress = "basicAddress"
        static let detailAddress = "detailAddress"
        
        static let productID = "productID"
        static let count = "count"
        static let price = "price"
        static let timestamp = "timestamp"
        
        static let recipeID = "recipeID"
    }
}
