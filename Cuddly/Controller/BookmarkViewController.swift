//
//  BookmarkViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/06/01.
//

import UIKit

class BookmarkViewController: UIViewController {

    // MARK: - Properties
    
    var navigation: CustomNavigation!
    var savedIndex: [Int] = [0, 2, 3]
    
    @IBOutlet weak var bookmarkTableView: UITableView!
    
    var bookmarks: [Recipe?] {
        let recipes = Recipe.fetchRecipes()
        var bookmarks: [Recipe?] = []
    
        for i in savedIndex {
            bookmarks.append(recipes[i])
        }

        return bookmarks
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    
        setDelegate()
    }
    
    // MARK: - Helpers
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
        
        navigation = CustomNavigation(superVC: self)
        navigation.setTitle(as: "북마크 레시피")
        navigation.initCartButton()
    }
    
    func setDelegate() {
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
    }
}


// MARK: - Extension TableView Delegate
extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.id, for: indexPath) as! BookmarkCell
        
        if let recipe = bookmarks[indexPath.row] {
            cell.configure(with: recipe)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        
        let vc = storyboard?.instantiateViewController(withIdentifier: K.id.recipeMainVC) as! RecipeMainViewController
        vc.recipe = bookmarks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
