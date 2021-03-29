//
//  RecipeBrain.swift
//  Cuddly
//
//  Created by Haru on 2021/03/28.
//

import UIKit

struct RecipeBrain {
    
    let allRecipes: [Recipe] = [
        Recipe(title: "퍼푸치노",
               subtitle: "따뜻하고 포근한 겨울을 위한 한 잔",
               time: "15분",
               effect: "모질 개선 기능",
               image: UIImage(named: "puppucinoMain.jpeg"),
               ingredients: [Ingredient(name: "락토프리 우유 혹은 펫밀크", weight: "150ml"),
                             Ingredient(name: "캐롭파우더", weight: "2tsp")],
               tools: ["전자레인지", "거품기"],
               target: .catAndDog,
               caution: "유당 분해가 어려운 반려동물을 위해 꼭 락토프리 우유 혹은 펫밀크를 이용해주세요.",
               steps: [Step(number: 1,
                            title: "우유 데워주기",
                            description: "준비된 락토프리 우유 혹은 펫밀크의 절반을 전자레인지용 그릇에 담아 30초 돌립니다.",
                            image: UIImage(systemName: "1.circle")),
                       Step(number: 2,
                            title: "우유와 캐롭파우더 섞기",
                            description: "데워진 우유 반 정도를 머그잔에 채워주고 캐롭파우더 1tsp을 넣어 우유와 잘 섞어줍니다.",
                            image: UIImage(systemName: "2.circle")),
                       Step(number: 3,
                            title: "우유거품 만들기",
                            description: "남은 우유는 거품기를 이용해 40초 정도 휘저어, 충분한 거품을 만들어줍니다.",
                            image: UIImage(systemName: "3.circle")),
                       Step(number: 4,
                            title: "우유거품 올리기",
                            description: "캐롭파우더를 섞은 우유 위에 거품을 올려줍니다.",
                            image: UIImage(systemName: "4.circle")),
                       Step(number: 5,
                            title: "캐롭파우더 토핑하기",
                            description: "거품 위 캐롭파우더를 솔솔 뿌려주면 완성!",
                            image: UIImage(systemName: "5.circle"))
               ],
               comments: nil,
               linkedProducts: nil)
    ]

//    let allRecipes = ["title1", "title2", "title3", "title4", "title5"]
}
