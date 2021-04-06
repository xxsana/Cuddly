//
//  RecipeMainViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/03/26.
//

import UIKit

class RecipeMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var effectLabel: UILabel!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var toolsLabel: UILabel!
    
    var recipeTabBarController: RecipeTabBarController!
    
    // 혹시 필요할까 싶어 받은 index 안 쓰면 지우기
    var indexNum = 0
    var recipe: Recipe! = nil       //okay with forced unwrap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tabBar
        self.recipeTabBarController = RecipeTabBarController(superView: self)
        self.view.addSubview(recipeTabBarController.customTabBar)
        
        titleLabel.text = recipe.title
        subtitleLabel.text = recipe.subtitle
        mainImageView.image = recipe.image
        
        // 배치 어디에?
        var targetString: String {
            switch recipe.target {
            case .onlyCat :
                return "고양이가 먹어요"
            case .onlyDog :
                return "강아지가 먹어요"
            case .catAndDog:
                return "강아지, 고양이 함께 먹어요"
            }
        }
        targetLabel.text = targetString
        timeLabel.text = recipe.time
        effectLabel.text = recipe.effect
        var toolString: String {
            if let unwrappedTools = recipe.tools {
                return unwrappedTools.joined(separator: ", ")
            } else {
                return "특별히 필요한 건 없어요"
            }
        }
        toolsLabel.text = toolString
        
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self

        // UI bar button item
        let blackBackItem = UIBarButtonItem(title: nil, style: .done, target: self, action: nil)
        blackBackItem.tintColor = .black
        self.navigationItem.backBarButtonItem = blackBackItem
        
        
        // line UI
        let lineViewAbove = UIView(frame: CGRect(x: 19, y: 560, width: 376, height: 1.2))
        lineViewAbove.layer.borderWidth = 374
        lineViewAbove.layer.borderColor = CGColor.init(red: 0.8627, green: 0.8627, blue: 0.8627, alpha: 1)
        
        let lineViewBelow = UIView(frame: CGRect(x: 19, y: 648, width: 376, height: 1.2))
        lineViewBelow.layer.borderWidth = 374
        lineViewBelow.layer.borderColor = CGColor.init(red: 0.8627, green: 0.8627, blue: 0.8627, alpha: 1)
        
        self.view.addSubview(lineViewAbove)
        self.view.addSubview(lineViewBelow)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell
        else {
            print("failed to create table view cell")
            let cell = IngredientTableViewCell(style: .default, reuseIdentifier: "IngredientCell")
            return cell
        }
        let ingredient = recipe.ingredients[indexPath.row]
        cell.name.text = ingredient.name
        cell.weight.text = ingredient.weight
        return cell
    }
}

class IngredientTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weight: UILabel!
    
}
