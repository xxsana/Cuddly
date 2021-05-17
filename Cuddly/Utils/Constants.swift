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
    
    // view controller identifier
    struct id {
        static let recipeStepVC = "RecipeStepViewController"
        static let recipeMainVC = "RecipeMainViewController"
        static let recipeStepCell = "StepCell"
        static let recipeListCell = "RecipeListCell"
        static let navigation = "NavigationController"
        static let customTabBar = "CustomTabBarController"
        static let logInVC = "LogInViewController"
        static let myPageNavigation = "MyPageNav"
    }
    
    struct Firebase {
        static let email = "email"
        static let username = "userName"
    }
}
