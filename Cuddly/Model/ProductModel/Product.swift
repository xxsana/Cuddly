//
//  Product.swift
//  Cuddly
//
//  Created by Haru on 2021/03/28.
//

import UIKit

struct Product {
    let name: String                //상품명
    let price: Int                  //가격
    let mainImage: UIImage?
    let descImages: [UIImage?]
    let productID: String
    var linkedRecipes: [Recipe]? {
        
        // recipe 모델을 다 돌면서 linked products의 이름과 일치하는 것만 저장한 배열을 리턴
        var links: [Recipe]?
        
        let allRecipes = Recipe.fetchRecipes()
        
        for recipe in allRecipes {
            if let products = recipe.linkedProducts {
                for product in products {
                    if self.name == product.name {
                        links?.append(recipe)
                    }
                }
            }
        }
        return links
    }
    
    static func findProduct(with productID: String) -> Product? {
        let allProducts: [Product] = fetchProducts()
        
        for product in allProducts {
            if product.productID == productID {
                return product
            }
        }
        return nil
    }
    
    static func fetchProducts() -> [Product]
    {
        
        var products = [Product]()
        
        let product1 = Product(name: "5단 식품건조기 KAFD-B230",
                               price: 36500,
                               mainImage: UIImage(named: "식품건조기Main.jpg"),
                               descImages: [
                                UIImage(named: "식품건조기1.jpg"),
                                UIImage(named: "식품건조기2.jpg"),
                                UIImage(named: "식품건조기3.jpg"),
                                UIImage(named: "식품건조기4.jpg"),
                                UIImage(named: "식품건조기5.jpg"),
                                UIImage(named: "식품건조기6.jpg")],
                               productID: "KAFDB230")
        let product2 = Product(name: "오리날개 90g",
                               price: 3900,
                               mainImage: UIImage(named: "오리날개Main.jpg"),
                               descImages: [
                                UIImage(named: "오리날개0.jpg")],
                               productID: "SNACK090")
        let product3 = Product(name: "5단 식품건조기 KAFD-B230",
                               price: 36500,
                               mainImage: UIImage(named: "식품건조기Main.jpg"),
                               descImages: [
                                UIImage(named: "식품건조기1.jpg"),
                                UIImage(named: "식품건조기2.jpg"),
                                UIImage(named: "식품건조기3.jpg"),
                                UIImage(named: "식품건조기4.jpg"),
                                UIImage(named: "식품건조기5.jpg"),
                                UIImage(named: "식품건조기6.jpg")],
                               productID: "KAFDB330")
        
        products.append(product1)
        products.append(product2)
        products.append(product2)
        products.append(product3)
        products.append(product1)
        products.append(product2)
        products.append(product2)
        products.append(product3)
        
        return products
    }
}
