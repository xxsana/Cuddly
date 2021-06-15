//
//  RecipeMainViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/03/26.
//

import UIKit

class RecipeMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BookmarkDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var infoStackView: UIStackView!
//    @IBOutlet weak var toolStackView: UIStackView!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var effectLabel: UILabel!
    @IBOutlet weak var toolsLabel: UILabel!
    
    let toolBar = UIView()
    var navigation: CustomNavigation!

    let toolItem01Home = CustomTabBarItem()
    let toolItem02Comment = CustomTabBarItem()
    let toolItem03Bookmark = CustomTabBarItem()
    let toolItem04LinkedProduct = CustomTabBarItem()

    var recipe: Recipe! = nil
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigation()
        setDelegate()
        setRecipeValue()
        
    }
    
    
    // MARK: - API
    
    func addToBookmark() {
        let id = recipe.recipeID
        BookmarkService.shared.uploadToBookmark(with: id) {
            
            // show alert that says it saved successfully
            let alertVC = UIAlertController(title: "북마크 되었습니다!", message: "북마크 탭에서 확인 해 주세요.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    // MARK:- Actions
    
    @IBAction func touchDownGoToDetailBtn(_ sender: UIButton) {
        sender.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        sender.setTitleColor(UIColor(red: 0.00, green: 0.91, blue: 0.36, alpha: 0.3), for: .normal)
    }
    
    @IBAction func pressedGoToDetailBtn(_ sender: UIButton) {
        sender.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        sender.setTitleColor(UIColor(named: "LightYellowGreen"), for: .normal)
            
        let vc = RecipeStepViewController()
        // pass value
        vc.recipe = recipe
        vc.recipeTitle = recipe.title
        vc.recipeSteps = recipe.steps
        vc.recipeCaution = recipe.caution

        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    // MARK:- table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
        let ingredient = recipe.ingredients[indexPath.row]
        cell.name.text = ingredient.name
        cell.weight.text = ingredient.weight
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    // MARK: - Helpers
    
    func configureNavigation() {
        navigation = CustomNavigation(superVC: self)
        navigation.initBackButton(tintWhite: true)
        navigation.initShareAndBookmarkButton(tintWhite: true)
    }
    
    func setDelegate() {
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        navigation.bookmarkDelegate = self
    }
    
    func setRecipeValue() {
        
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
        
       var toolString: String {
           if let unwrappedTools = recipe.tools {
               return unwrappedTools.joined(separator: ", ")
           } else {
               return "특별히 필요한 건 없어요"
           }
       }
        
        mainImageView.image = recipe.image
        subtitleLabel.text = recipe.subtitle
        titleLabel.text = recipe.title
        targetLabel.text = targetString
        timeLabel.text = recipe.time
        effectLabel.text = recipe.effect
        toolsLabel.text = toolString
        
    }

    
}

class IngredientTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weight: UILabel!
}
