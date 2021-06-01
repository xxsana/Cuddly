//
//  Product.swift
//  Cuddly
//
//  Created by Haru on 2021/03/28.
//

import UIKit

struct Product {
    let name: String
    let price: Int
    var mainImage: UIImage? {
        return UIImage(named: "\(productID)_main")
    }
    let descImages: [UIImage?]
    let productID: String

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
        let helper = ImageNamingHelper()
        
        let p1Images = helper.creatDesc(with: "BANGB450", to: 10)
        let p2Images = helper.creatDesc(with: "BANGB470", to: 10)
        let p3Images = helper.creatDesc(with: "BANGB460", to: 10)
        let p4Images = helper.creatDesc(with: "BANGB480", to: 10)
        let p5Images = helper.creatDesc(with: "KITDR500", to: 5)
        let p6Images = helper.creatDesc(with: "SHBLE490", to: 7)
        let p7Images = helper.creatDesc(with: "KLAMI880", to: 4)
        let p8Images = helper.creatDesc(with: "DCHDU980", to: 3)
        let p9Images = helper.creatDesc(with: "DCHDU990", to: 3)
        let p10Images = helper.creatDesc(with: "THERI210", to: 3)
        let p11Images = helper.creatDesc(with: "THERI220", to: 3)
        let p12Images = helper.creatDesc(with: "BONIT110", to: 5)
        let p13Images = helper.creatDesc(with: "BONIT120", to: 5)
        let p14Images = helper.creatDesc(with: "BONIT130", to: 5)
        let p15Images = helper.creatDesc(with: "CHAMJ310", to: 1)
        let p16Images = helper.creatDesc(with: "PREIT450", to: 6)
        let p17Images = helper.creatDesc(with: "PREIT440", to: 6)
        let p18Images = helper.creatDesc(with: "PREIT460", to: 5)
        
        
        let p1 = Product(name: "반작작업실 멍김밥 DIY 키트",
                               price: 12900,
                               descImages: p1Images,
                               productID: "BANGB450")
        
        let p2 = Product(name: "반작작업실 멍카레 DIY 키트",
                               price: 12000,
                               descImages: p2Images,
                               productID: "BANGB470")
        
        let p3 = Product(name: "반작작업실 밀크초콜릿 DIY 키트",
                               price: 9900,
                               descImages: p3Images,
                               productID: "BANGB460")
        
        let p4 = Product(name: "반작작업실 비프타르트 DIY 키트",
                               price: 12900,
                               descImages: p4Images,
                               productID: "BANGB480")
        
        let p5 = Product(name: "키친아트 식품건조기",
                               price: 29900,
                               descImages: p5Images,
                               productID: "KITDR500")
        
        let p6 = Product(name: "클레버 핸드블렌더",
                               price: 19900,
                               descImages: p6Images,
                               productID: "SHBLE490")
        
        let p7 = Product(name: "클라쎄 전자렌지",
                               price: 71000,
                               descImages: p7Images,
                               productID: "KLAMI880")
        
        let p8 = Product(name: "청림 오리날개뼈 3kg",
                               price: 35600,
                               descImages: p8Images,
                               productID: "DCHDU980")
        
        let p9 = Product(name: "청림 오리목뼈 3kg",
                               price: 35600,
                               descImages: p9Images,
                               productID: "DCHDU990")
        
        let p10 = Product(name: "더리치플러스 오리바 300g",
                               price: 1900,
                               descImages: p10Images,
                               productID: "THERI210")
        
        let p11 = Product(name: "더리치플러스 오리육포 300g",
                               price: 1900,
                               descImages: p11Images,
                               productID: "THERI220")
        
        let p12 = Product(name: "보니또댕댕이 치킨빼로로 300g",
                               price: 1900,
                               descImages: p12Images,
                               productID: "BONIT110")
        
        let p13 = Product(name: "보니또댕댕이 치킨윙 300g",
                               price: 1900,
                               descImages: p13Images,
                               productID: "BONIT120")
        
        let p14 = Product(name: "보니또댕댕이 닭고기사각큐브 300g",
                               price: 1900,
                               descImages: p14Images,
                               productID: "BONIT130")
        
        let p15 = Product(name: "참좋은간식 텐더츄 링",
                               price: 1900,
                               descImages: p15Images,
                               productID: "CHAMJ310")
        
        let p16 = Product(name: "페리또얌 츄르 참치&닭고기맛",
                               price: 1900,
                               descImages: p16Images,
                               productID: "PREIT450")
        
        let p17 = Product(name: "페리또얌 츄르 참치&연어맛",
                               price: 1900,
                               descImages: p17Images,
                               productID: "PREIT440")
        let p18 = Product(name: "페리또얌 츄르 참치맛",
                               price: 1900,
                               descImages: p18Images,
                               productID: "PREIT460")
        
        products.append(p1)
        products.append(p2)
        products.append(p3)
        products.append(p4)
        products.append(p5)
        products.append(p6)
        products.append(p7)
        products.append(p8)
        products.append(p9)
        products.append(p10)
        products.append(p11)
        products.append(p12)
        products.append(p13)
        products.append(p14)
        products.append(p15)
        products.append(p16)
        products.append(p17)
        products.append(p18)

        
        return products
    }
    
}
