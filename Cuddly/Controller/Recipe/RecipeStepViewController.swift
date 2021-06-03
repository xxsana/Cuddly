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
    
    // 이거 하나만 쓰는 걸로 바꾸기
    var recipe: Recipe!
    
    var recipeTitle: String!
    var recipeSteps: [Step]!
    var recipeCaution: String? = ""
    var cautionContainer: UIView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create navigation bar
        navigation = CustomNavigation(superVC: self)
        guard let title = recipeTitle else {
            print("cannot unwrap recipeTitle")
            return
        }
        
        navigation.setTitle(as: title)
        navigation.initBackButton(dismiss: true)
        navigation.initShareAndBookmarkButton()

        self.view.backgroundColor = .white
        
        if recipeCaution != nil {
            configureCautionView()
        }
        
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
    
    
    func configureCautionView() {
        cautionContainer = UIView()
        self.view.addSubview(cautionContainer)
        
        // auto layout container
        cautionContainer.translatesAutoresizingMaskIntoConstraints = false
        cautionContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cautionContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0).isActive = true
        cautionContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cautionContainer.sizeToFit()

        let noticeIcon = UIImageView()
        let noticeLabel = UILabel()
        let cautionLabel = UILabel()
        let line = UIView()

        cautionContainer.addSubview(noticeIcon)
        cautionContainer.addSubview(noticeLabel)
        cautionContainer.addSubview(cautionLabel)
        cautionContainer.addSubview(line)

        // configure notice icon
        noticeIcon.image = UIImage(systemName: "exclamationmark.circle.fill",
                                   withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold))
        noticeIcon.tintColor = UIColor(named: K.lightYellowGreen)

        // auto layout notice icon
        noticeIcon.translatesAutoresizingMaskIntoConstraints = false
        noticeIcon.topAnchor.constraint(equalTo: cautionContainer.topAnchor, constant: 15.0).isActive = true
        noticeIcon.leadingAnchor.constraint(equalTo: cautionContainer.leadingAnchor, constant: 20.0).isActive = true
        
        // configure notice label
        noticeLabel.text = "간식 조리와 급여 전 꼭 주의사항 확인이 필요해요"
        noticeLabel.font = UIFont(name: K.appleSDGothicNeo_Bold, size: 15.0)
        noticeLabel.sizeToFit()
        
        // auto layout notice label
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeLabel.topAnchor.constraint(equalTo: cautionContainer.topAnchor, constant: 15.0).isActive = true
        noticeLabel.centerYAnchor.constraint(equalTo: noticeIcon.centerYAnchor).isActive = true
        noticeLabel.leadingAnchor.constraint(equalTo: noticeIcon.trailingAnchor, constant: 10.3).isActive = true

        // configure caution label
        cautionLabel.text = recipeCaution
        cautionLabel.font = UIFont(name: K.appleSDGothicNeo_Medium, size: 14.0)
        cautionLabel.numberOfLines = 0
        cautionLabel.lineBreakMode = .byWordWrapping
        cautionLabel.sizeToFit()
        
        // auto layout caution label
        cautionLabel.translatesAutoresizingMaskIntoConstraints = false
        cautionLabel.centerXAnchor.constraint(equalTo: cautionContainer.centerXAnchor).isActive = true
        cautionLabel.topAnchor.constraint(equalTo: noticeLabel.bottomAnchor, constant: 20.0).isActive = true
        cautionLabel.leadingAnchor.constraint(equalTo: noticeIcon.trailingAnchor, constant: 10.3).isActive = true
        cautionLabel.trailingAnchor.constraint(equalTo: cautionContainer.trailingAnchor, constant: -45.0).isActive = true
    
        // draw gray line
        line.backgroundColor = UIColor(white: 0.4, alpha: 0.15)
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        line.leadingAnchor.constraint(equalTo: cautionContainer.leadingAnchor, constant: 20.0).isActive = true
        line.trailingAnchor.constraint(equalTo: cautionContainer.trailingAnchor, constant: -20.0).isActive = true
        line.topAnchor.constraint(equalTo: cautionLabel.bottomAnchor, constant: 20.0).isActive = true
        line.bottomAnchor.constraint(equalTo: cautionContainer.bottomAnchor, constant: -1.0).isActive = true
        
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
            if cautionContainer != nil {
                tableView.topAnchor.constraint(equalTo: cautionContainer.bottomAnchor, constant: 10.0).isActive = true
            } else {
                tableView.topAnchor.constraint(equalTo: navigation.csNavigationBar.bottomAnchor, constant: 10.0).isActive = true
            }
        }

}

extension RecipeStepViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeSteps.count
    }
    
    func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.id.recipeStepCell) as! StepTableViewCell
        let step = recipeSteps[indexPath.row]
        cell.set(step: step)
        cell.selectionStyle = .none
        return cell
    }
    
}
