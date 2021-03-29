//
//  ViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/03/25.
//

import UIKit

class RecipeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let allRecipes = RecipeBrain().allRecipes
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // transparent Navigation Controller
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // UI bar button item
        let backItem = UIBarButtonItem(title: nil, style: .done, target: self, action: nil)
        backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem
    }
    
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EachRecipe", for: indexPath)
        cell.textLabel?.text = allRecipes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeMain") as? RecipeMainViewController
        else {
            print("failed to instantiate view controller with RecipeMain")
            return
        }
        
        mainVC.indexNum = indexPath.row
        mainVC.recipe = allRecipes[indexPath.row]
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    

}
