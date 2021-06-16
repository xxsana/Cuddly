//
//  RecipeDetailViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/12.
//

import UIKit

class RecipeStepViewController: UIViewController, BookmarkDelegate {

    var navigation: CustomNavigation!
    var tableView = UITableView()
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create navigation bar
        navigation = CustomNavigation(superVC: self)
        
        navigation.setTitle(as: recipe.title)
        navigation.initBackButton(dismiss: true)
        navigation.initShareAndBookmarkButton()

        self.view.backgroundColor = .white
        
        // table view setting
        configureTableView()
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
    
    func configureTableView() {

        self.view.addSubview(tableView)
        
        // set other delegates
        setDelegate()
        
        // set row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        // register cells
        tableView.register(StepTableViewCell.self, forCellReuseIdentifier: K.id.recipeStepCell)
        
        // set constraints
        pin()
        }

        func setDelegate() {
            tableView.delegate = self
            tableView.dataSource = self
            navigation.bookmarkDelegate = self
        }

        func pin() {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: navigation.csNavigationBar.bottomAnchor, constant: 4.0).isActive = true
        }

}

extension RecipeStepViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.steps.count
    }
    
    func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.id.recipeStepCell) as! StepTableViewCell
        let step = recipe.steps[indexPath.row]
        cell.set(step: step)
        cell.selectionStyle = .none
        return cell
    }
    
}
