//
//  ViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/03/25.
//

import UIKit

class RecipeListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // transparent Navigation Controller
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // UI bar button item
        let backItem = UIBarButtonItem(title: nil, style: .done, target: self, action: nil)
        backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem
    }
    

}
