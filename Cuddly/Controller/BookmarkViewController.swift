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
    var bookmarks = [Recipe]()
    
    @IBOutlet weak var bookmarkTableView: UITableView!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    
        fetchBookmark()
        
        setDelegate()
    }
    
    // MARK: - API
    
    func fetchBookmark() {
        BookmarkService.shared.fetchBookmarks(completion: { id in
            // user insert() for showing by recently added recipes.
            if let recipe = Recipe.findRecipe(with: id) {
                self.bookmarks.insert(recipe, at: 0)
                self.bookmarkTableView.reloadData()
            }
        })
    }
    
    // MARK: - Helpers
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
        
        navigation = CustomNavigation(superVC: self)
        navigation.setTitle(as: "북마크 레시피", withLogo: true)
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

        let recipe = bookmarks[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        
        let vc = storyboard?.instantiateViewController(withIdentifier: K.id.recipeMainVC) as! RecipeMainViewController
        vc.recipe = bookmarks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let id = bookmarks[indexPath.row].recipeID
            
            bookmarks.remove(at: indexPath.row)
            BookmarkService.shared.delete(id)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
}
