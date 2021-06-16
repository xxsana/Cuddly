//
//  Recipe.swift
//  Cuddly
//
//  Created by Haru on 2021/03/28.
//

import UIKit

enum Target {
    case onlyCat
    case onlyDog
    case catAndDog
}

struct Ingredient {
    let name: String
    let weight: String
}

struct Step {
    let number: Int         //순서
    let title: String       //단계 제목
    let description: String //설명
    let image: UIImage?     //단계별 이미지
}

struct Recipe {
    let title: String               //제목
    let subtitle: String            //소제목
    let time: String                //소요시간
    let effect: String              //효능효과
    let image: UIImage?             //메인이미지
    let ingredients: [Ingredient]   //재료
    let tools: [String]?            //도구
    let target: Target              //급여가능대상
    let caution: String?            //주의사항
    let steps: [Step]               //제조과정
    let recipeID: String
    
    static func findRecipe(with recipeID: String) -> Recipe? {
        let allRecipes = fetchRecipes()
        
        for recipe in allRecipes {
            if recipe.recipeID == recipeID {
                return recipe
            }
        }
        return nil
    }
    
    static func fetchRecipes() -> [Recipe] {
        var recipes = [Recipe]()
        
        let r1 = Recipe(title: "퍼푸치노",
                        subtitle: "포근한 겨울을 위한 한 잔",
                        time: "15분",
                        effect: "모질 개선 기능",
                        image: UIImage(named: "puppuchi_main"),
                        ingredients: [Ingredient(name: "락토프리 우유 혹은 펫밀크", weight: "150ml"),
                                      Ingredient(name: "캐롭파우더", weight: "2tsp")],
                        tools: ["전자렌지", "거품기"],
                        target: .catAndDog,
                        caution: "유당 분해가 어려운 반려동물을 위해 꼭 락토프리 우유 혹은 펫밀크를 이용해주세요.",
                        steps: [Step(number: 1,
                                     title: "우유 데워주기",
                                     description: "준비된 락토프리 우유 혹은 펫밀크의 절반을 전자렌지용 그릇에 담아 30초 돌립니다.",
                                     image: UIImage(named: "puppuchi_1")),
                                Step(number: 2,
                                     title: "우유와 캐롭파우더 섞기",
                                     description: "데워진 우유 반 정도를 머그잔에 채워주고 캐롭파우더 1tsp을 넣어 우유와 잘 섞어줍니다.",
                                     image: UIImage(named: "puppuchi_2")),
                                Step(number: 3,
                                     title: "우유거품 만들기",
                                     description: "남은 우유는 거품기를 이용해 40초 정도 휘저어, 충분한 거품을 만들어줍니다.",
                                     image: UIImage(named: "puppuchi_3")),
                                Step(number: 4,
                                     title: "우유거품 올리기",
                                     description: "캐롭파우더를 섞은 우유 위에 거품을 올려줍니다.",
                                     image: UIImage(named: "puppuchi_4")),
                                Step(number: 5,
                                     title: "캐롭파우더 토핑하기",
                                     description: "거품 위 캐롭파우더를 솔솔 뿌려주면 완성!",
                                     image: UIImage(named: "puppuchi_5"))
                        ],
                        recipeID: "puppuchi")
        
        let r2 = Recipe(title: "고구마 치즈볼",
                        subtitle: "겉은 바삭 속은 촉촉한 간식",
                        time: "14시간 30분",
                        effect: "장내 유익균 증식",
                        image: UIImage(named: "swtpocheese_main"),
                        ingredients: [Ingredient(name: "고구마", weight: "500g"),
                                      Ingredient(name: "락토프리우유", weight: "1L"),
                                      Ingredient(name: "식초(레몬즙 대체가능)", weight: "4T")],
                        tools: ["건조기", "거름망", "면보", "짤주머니"],
                        target: .onlyDog,
                        caution: nil,
                        steps: [Step(number: 1,
                                     title: "고구마 찌기",
                                     description: "고구마를 껍질을 벗긴 채 삶아주세요! (수분이 많은 호박고구마 추천)",
                                     image: UIImage(named: "swtpocheese_1")),
                                Step(number: 2,
                                     title: "우유 끓이기",
                                     description: "락토프리우유를 중불에 끓이다가 테두리에 거품이 생기면 약한불로 줄여주세요",
                                     image: UIImage(named: "swtpocheese_2")),
                                Step(number: 3,
                                     title: "식초 넣기",
                                     description: "우유막이 생기면 식초(혹은 레몬즙)을 4스푼 넣어주세요. 금방 부풀어오르며 유청이 분리됩니다. 살짝씩만 저어주세요.",
                                     image: UIImage(named: "swtpocheese_3")),
                                Step(number: 4,
                                     title: "코티지치즈 만들기",
                                     description: "젖은 면보를 깔고 치즈를 부어준 후 꼭 짜 주세요. (뜨거우니 손 조심!)",
                                     image: UIImage(named: "swtpocheese_4")),
                                Step(number: 5,
                                     title: "고구마와 코티지치즈 섞기",
                                     description: "물렁해진 고구마를 잘 으깨줍니다. (너무 되직하면 물 혹은 락토프리우유를 넣어주어도 좋아요!) 으깬 고구마 위에 코티지치즈를 섞어주세요.",
                                     image: UIImage(named: "swtpocheese_5")),
                                Step(number: 6,
                                     title: "건조기에 짜기",
                                     description: "짤주머니에 내용물을 담은 후 원하는 두께, 길이를 고려하여 짜주세요. (건조 후엔 1/3정도 크기가 줄어듭니다) 크기가 일정해야 잘 건조됩니다.",
                                     image: UIImage(named: "swtpocheese_6")),
                                Step(number: 7,
                                     title: "건조기 돌리기",
                                     description: "건조기에서 60도 14시간 설정 후 기다립니다",
                                     image: UIImage(named: "swtpocheese_7")),
                                Step(number: 8,
                                     title: "완성!",
                                     description: "꼭 냉동, 냉장보관 해주세요",
                                     image: UIImage(named: "swtpocheese_8"))],
                        recipeID: "swtpocheese")
        
        let r3 = Recipe(title: "멍케잌",
                        subtitle: "우리 강아지 생일파티",
                        time: "45분",
                        effect: "영양보충",
                        image: UIImage(named: "facecake_main"),
                        ingredients: [Ingredient(name: "닭가슴살", weight: "50g"),
                                      Ingredient(name: "고구마", weight: "1ea"),
                                      Ingredient(name: "캔사료", weight: "1ea"),
                                      Ingredient(name: "당근", weight: "조금"),
                                      Ingredient(name: "블루베리", weight: "2ea")],
                        tools: ["전자렌지", "종이호일"],
                        target: .onlyDog,
                        caution: nil,
                        steps: [Step(number: 1,
                                     title: "닭가슴살 삶기",
                                     description: "닭가슴살을 잘 익히기 위해 덩어리에 칼집을 내준 후 끓는 물에 삶아주세요.",
                                     image: UIImage(named: "facecake_1")),
                                Step(number: 2,
                                     title: "단호박, 고구마 익히기",
                                     description: "깨끗이 씻은 채소를 종이호일이나 신문지로 꼼꼼히 싸주세요. 통째로 촉촉하게 물기를 적혀 전자렌지에서 10~15분간 익혀주세요.",
                                     image: UIImage(named: "facecake_2")),
                                Step(number: 3,
                                     title: "닭가슴살 잘게 썰기",
                                     description: "잘 삶아진 닭가슴살을 잘게 썰어주세요. 쭉쭉 찢어도 괜찮습니다.",
                                     image: UIImage(named: "facecake_3")),
                                Step(number: 4,
                                     title: "채소와 캔사료 섞어주기",
                                     description: "익힌 단호박과 고구마, 캔 사료를 넣고 섞어주세요.",
                                     image: UIImage(named: "facecake_4")),
                                Step(number: 5,
                                     title: "모양 만들기",
                                     description: "채소와 섞은 캔사료로 얼굴 모양을 낸 후 닭가슴살로 무늬를 잡아주세요.",
                                     image: UIImage(named: "facecake_5")),
                                Step(number: 6,
                                     title: "눈코입 그리기",
                                     description: "블루배리, 당근 등으로 눈과 코도 만들어주세요. ",
                                     image: UIImage(named: "facecake_6")),
                                Step(number: 7,
                                     title: "완성!",
                                     description: "맛있게 먹는 강아지를 보며 흐뭇해해요",
                                     image: UIImage(named: "facecake_7"))],
                        recipeID: "facecake")
        
        let r4 = Recipe(title: "호박요거트빵",
                        subtitle: "비타민A와 식이섬유가 풍부한",
                        time: "30분",
                        effect: "단백질보충",
                        image: UIImage(named: "yogubang_main"),
                        ingredients: [Ingredient(name: "단호박", weight: "200g"),
                                      Ingredient(name: "무당요거트", weight: "100ml"),
                                      Ingredient(name: "달걀", weight: "1ea"),
                                      Ingredient(name: "꿀", weight: "1T"),
                                      Ingredient(name: "블루베리", weight: "3ea")],
                        tools: ["전자렌지", "냄비"],
                        target: .onlyDog,
                        caution: nil,
                        steps: [Step(number: 1,
                                     title: "단호박 손질하기",
                                     description: "단호박을 전자렌지에 2분정도 돌린 후 8등분으로 잘라줍니다. 씨도 제거 해 주세요.",
                                     image: UIImage(named: "yogubang_1")),
                                Step(number: 2,
                                     title: "단호박 찌기",
                                     description: "냄비 뚜껑을 닫고 강불에 13분 정도 쪄주면 촉촉하고 부드러워집니다.",
                                     image: UIImage(named: "yogubang_2")),
                                Step(number: 3,
                                     title: "단호박 으깨기",
                                     description: "찐 단호박의 껍질을 제거한 후 볼에 담아 부드럽게 으깨줍니다.",
                                     image: UIImage(named: "yogubang_3")),
                                Step(number: 4,
                                     title: "달걀과 함께 익히기",
                                     description: "으깬 단호박에 달걀 하나를 넣고 섞은 후 전자레이지에 5분 돌려줍니다.",
                                     image: UIImage(named: "yogubang_4")),
                                Step(number: 5,
                                     title: "잘라서 볼에 넣기",
                                     description: "완성된 단호박 빵을 먹기 좋은 크기로 자른 후 볼이나 강아지 그릇에 담아줍니다.",
                                     image: UIImage(named: "yogubang_5")),
                                Step(number: 6,
                                     title: "요거트 섞기",
                                     description: "플레인 요거트가 잘 스며들도록 골고루 부어주고 블루베리를 올려 플레이팅 해 주면 완성!",
                                     image: UIImage(named: "yogubang_6"))],
                        recipeID: "yogubang")
        
        let r5 = Recipe(title: "단호박전",
                        subtitle: "설사와 변비예방에 효과적인",
                        time: "30분",
                        effect: "소화도움",
                        image: UIImage(named: "swpujeon_main"),
                        ingredients: [Ingredient(name: "단호박", weight: "200g"),
                                      Ingredient(name: "닭안심", weight: "100g"),
                                      Ingredient(name: "쌀가루", weight: "50g"),
                                      Ingredient(name: "올리브오일", weight: "조금")],
                        tools: ["후라이팬"],
                        target: .onlyDog,
                        caution: nil,
                        steps: [Step(number: 1,
                                     title: "재료준비",
                                     description: "곱게 진 단호박과 나머지 재료를 준비 해 주세요.",
                                     image: UIImage(named: "swpujeon_1")),
                                Step(number: 2,
                                     title: "닭안심 다지기",
                                     description: "닭안심을 다지기에 넣고 곱게 다져줍니다.",
                                     image: UIImage(named: "swpujeon_2")),
                                Step(number: 3,
                                     title: "반죽하기",
                                     description: "으깬 단호박과 닭안심을 볼에 넣어 섞어주다가 쌀가루를 넣고 골고루 섞어서 반죽 해 줍니다.",
                                     image: UIImage(named: "swpujeon_3")),
                                Step(number: 4,
                                     title: "전 부치기",
                                     description: "달군 팬에 올리브오일을 살짝 두른 후 강아지가 먹기 좋은 크기로 앞뒤로 부쳐주세요.",
                                     image: UIImage(named: "swpujeon_4")),
                                Step(number: 5,
                                     title: "완성",
                                     description: "예쁜 그릇에 담아주면 완성!",
                                     image: UIImage(named: "swpujeon_5"))],
                        recipeID: "swpujeon")
        
        
        let r6 = Recipe(title: "피넛버터 트릿",
                        subtitle: "쉽고 간단한 훈련간식",
                        time: "50분",
                        effect: "단백질보충",
                        image: UIImage(named: "nutcookie_main"),
                        ingredients: [Ingredient(name: "호박 퓨레", weight: "2/3cup"),
                                      Ingredient(name: "피넛버터", weight: "1/4cup"),
                                      Ingredient(name: "달걀", weight: "2ea"),
                                      Ingredient(name: "밀가루", weight: "2.5~3cup")],
                        tools: ["오븐", "믹서기"],
                        target: .onlyDog,
                        caution: nil,
                        steps: [Step(number: 1,
                                     title: "오븐 예열하기",
                                     description: "180도로 예열된 오븐에 오븐용 시트지를 깔아둡니다.",
                                     image: UIImage(named: "nutcookie_1")),
                                Step(number: 2,
                                     title: "재료 섞기",
                                     description: "믹서기에 호박 퓨레와 피넛 버터, 달걀을 넣고 1-2분간 잘 갈아줍니다. 점점 밀가루를 추가해가며 약하게 믹서해줍니다. 도우가 더 이상 끈적거리지 않을 때 까지 추가 해 주세요.",
                                     image: UIImage(named: "nutcookie_2")),
                                Step(number: 3,
                                     title: "틀 따기",
                                     description: "도우를 3-4배로 펴준 후, 쿠키 틀을 이용해 모양을 냅니다.",
                                     image: UIImage(named: "nutcookie_3")),
                                Step(number: 4,
                                     title: "오븐에 굽기",
                                     description: "오븐에 넣고 가장자리가 노릇해 질 때까지 구워주세요. 약 20~25분쯤 걸립니다.",
                                     image: UIImage(named: "nutcookie_4")),
                                Step(number: 5,
                                     title: "식히기",
                                     description: "잘 구워진 쿠키를 식혀주세요.",
                                     image: UIImage(named: "nutcookie_5"))],
                        recipeID: "nutcookie")
        
        let r7 = Recipe(title: "고양이 츄르",
                        subtitle: "영양가득",
                        time: "50분",
                        effect: "영양분 보충",
                        image: UIImage(named: "churu_main"),
                        ingredients: [Ingredient(name: "닭가슴살", weight: "100g"),
                                      Ingredient(name: "단호박", weight: "50g"),
                                      Ingredient(name: "멸치가루(선택)", weight: "5g"),
                                      Ingredient(name: "콩가루", weight: "10g"),
                                      Ingredient(name: "당근", weight: "30g"),
                                      Ingredient(name: "북어가루", weight: "10g"),
                                      Ingredient(name: "영양제(선택)", weight: "50g")],
                        tools: ["전자렌지", "냄비", "믹서기"],
                        target: .onlyCat,
                        caution: nil,
                        steps: [Step(number: 1,
                                     title: "닭가슴살 삶기",
                                     description: "냄비에 물 500ml에 닭가슴살을 넣어 끓여줍니다.",
                                     image: UIImage(named: "churu_1")),
                                Step(number: 2,
                                     title: "단호박 준비하기",
                                     description: "단호박을 통째로 전자렌지에 5분 돌린 후 속씨를 파 냅니다.",
                                     image: UIImage(named: "churu_2")),
                                Step(number: 3,
                                     title: "재료 넣기",
                                     description: "적당히 깍뚝썰기 한 당근과 삶은 단호박을 삶아지고 있는 닭가슴살 육수에 넣어주세요.",
                                     image: UIImage(named: "churu_3")),
                                Step(number: 4,
                                     title: "육수 삶기",
                                     description: "닭가슴살을 잘라보며 부드럽게 익었는지 확인될 때 까지 삶아줍니다. 끓으면서 거품도 걸러 내 주세요. 당근이 물러지면 불을 끄고 식혀주세요.",
                                     image: UIImage(named: "churu_4")),
                                Step(number: 5,
                                     title: "믹서기에 갈기",
                                     description: "적당량을 골고루 믹서기에 담고 기호성을 위한 북어트릿 등을 함께 갈아줍니다. 질감을 위해 콩가루를 추가해도 좋아요. 너무 물러지면 육수를 더 넣어주세요.",
                                     image: UIImage(named: "churu_5")),
                                Step(number: 6,
                                     title: "보관하기",
                                     description: "완성! 그대로 보관하셔도 되고 츄르 포장스틱에 소분하셔도 됩니다.",
                                     image: UIImage(named: "churu_6"))],
                        recipeID: "churu")
        
        recipes.append(r1)
        recipes.append(r2)
        recipes.append(r7)
        recipes.append(r3)
        recipes.append(r6)
        recipes.append(r4)
        recipes.append(r5)
        
        return recipes
    }
}


