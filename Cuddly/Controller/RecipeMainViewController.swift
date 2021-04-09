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

    let toolBar = UIView()
    var csNavigationController: CustomNavigationController!

    let toolItem01Home = CustomTabBarItem()
    let toolItem02Comment = CustomTabBarItem()
    let toolItem03Bookmark = CustomTabBarItem()
    let toolItem04LinkedProduct = CustomTabBarItem()

    
    // 혹시 필요할까 싶어 받은 index 안 쓰면 지우기
    var indexNum = 0
    var recipe: Recipe! = nil       //okay with forced unwrap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation controller
        csNavigationController = CustomNavigationController(superVC: self)
        csNavigationController.setUpNavigationBar()
        csNavigationController.backButton()
        csNavigationController.shareAndBookmarkButton()
        
        // toolBar
        setUpToolBar()
        
        // 레이블 값 대입
        titleLabel.text = recipe.title
        subtitleLabel.text = recipe.subtitle
        mainImageView.image = recipe.image
        
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
    
    

    // table view
    
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
    
    // toolbar
    func setUpToolBar() {
        
        self.tabBarController?.tabBar.isHidden = true
        
        // TabBar size
        let width = self.view.frame.width
        let height: CGFloat = 90
        let x: CGFloat = 0
        let y = self.view.frame.height - height
        
        self.toolBar.frame = CGRect(x: x, y: y, width: width, height: height)
        self.toolBar.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
        
        // add subview
        self.view.addSubview(toolBar)
        
        // origin(point) of tabItems, height width는 있음
        let toolItemWidth = self.toolBar.frame.size.width / 4
        
        // arrange items with x
        self.toolItem01Home.frame.origin.x = 0
        self.toolItem02Comment.frame.origin.x = toolItemWidth
        self.toolItem03Bookmark.frame.origin.x = toolItemWidth * 2
        self.toolItem04LinkedProduct.frame.origin.x = toolItemWidth * 3
        
        // set image and title
        self.toolItem01Home.setImageAndTitle(title: "홈", imageSystemName: "house", tag: 0)
        self.toolItem02Comment.setImageAndTitle(title: "댓글", imageSystemName: "square.and.pencil", tag: 1)
        self.toolItem03Bookmark.setImageAndTitle(title: "저장 목록", imageSystemName: "heart", tag: 2)
        self.toolItem04LinkedProduct.setImageAndTitle(title: "관련제품", imageSystemName: "cart", tag: 3)
        
        
        // add action methods
        toolItem01Home.addTarget(self, action: #selector(tabItem01HomeClicked(_:)), for: .touchUpInside)
        toolItem02Comment.addTarget(self, action: #selector(tabItem02CommentClicked(_:)), for: .touchUpInside)
        toolItem03Bookmark.addTarget(self, action: #selector(tabItem03BookmarkClicked(_:)), for: .touchUpInside)
        toolItem04LinkedProduct.addTarget(self, action: #selector(tabItem04LinkedProductClicked(_:)), for: .touchUpInside)
        
        
        let items = [toolItem01Home, toolItem02Comment, toolItem03Bookmark, toolItem04LinkedProduct]
        
        for item in items {
            // add subview
            self.toolBar.addSubview(item)
            
            // align center
            guard let imageWidth = item.imageView?.frame.width
            else { print("fail to unwrap item.imageView?.frame.width"); return}
            guard let titleWidth = item.titleLabel?.frame.width
            else { print("fail to unwrap item.titleLabel?.frame.width"); return}
            item.alignImageAndTitleCenter(image: imageWidth, title: titleWidth)
        }
    }

    // tool bar action methods
    @objc func tabItem01HomeClicked(_ sender: CustomTabBarItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tabItem02CommentClicked(_ sender: CustomTabBarItem) {
        if let commentVC = self.storyboard?.instantiateViewController(withIdentifier: "Comment") {
            commentVC.modalPresentationStyle = .fullScreen
            self.present(commentVC, animated: true, completion: nil)
        }
    }
    
    @objc func tabItem03BookmarkClicked(_ sender: CustomTabBarItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tabItem04LinkedProductClicked(_ sender: CustomTabBarItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

class IngredientTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weight: UILabel!
    
}
