//
//  Recipe.swift
//  Cuddly
//
//  Created by Haru on 2021/03/28.
//

import UIKit

struct Recipe {
    let title: String               //제목
    let subtitle: String            //소제목
    let time: String                //소요시간
    let effect: String
    let image: UIImage?             //메인이미지
    let ingredients: [Ingredient]   //재료
    let tools: [String]?            //도구
    let target: Target              //급여가능대상
    let caution: String?            //주의사항
    let steps: [Step]
    let comments: [Comment]?        //댓글
    let linkedProducts: [Product]?  //관련제품
}
