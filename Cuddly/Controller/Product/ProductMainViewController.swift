//
//  ProductMainViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/21.
//

import UIKit

class ProductMainViewController: UIViewController {

    // MARK: - Properties
    var product: Product!
    var navigation: CustomNavigation!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var purchaseButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hideTabBar()
        
        configureNavigation()
        
        roundButtonBorder()
        
        tableViewDelegate()
        
        tableRegister()
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        print(product.name)
        print(product.descImages)
        
    }


    // MARK: - IBActions
    @IBAction func purchaseButtonClicked(_ sender: UIButton) {
    }
    
    

    // MARK: - Helpers
    
    func hideTabBar() {
        let tabBar = self.tabBarController as! MainTabController
        tabBar.hideTabBar()
    }
    
    func configureNavigation() {
        // change status bar color
        self.navigationController?.navigationBar.barStyle = .black
        
        // create custom navigation
        navigation = CustomNavigation(superVC: self)
        navigation.initBackButton(tintWhite: true, showTab: true)
        navigation.initCartButton(tintWhite: true)
    }
    
    func roundButtonBorder() {
        purchaseButton.layer.cornerRadius = 8.0
        purchaseButton.clipsToBounds = true
    }

    func tableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableRegister() {
        tableView.register(ProductMainCellOne.nib(), forCellReuseIdentifier: ProductMainCellOne.identifier)
        
        tableView.register(ProductMainCellTwo.nib(), forCellReuseIdentifier: ProductMainCellTwo.identifier)
        
        tableView.register(ProductMainCellThree.nib(), forCellReuseIdentifier: ProductMainCellThree.identifier)
    }
}


// MARK: - Extension for table view

extension ProductMainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.descImages.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            // show main image cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductMainCellOne.identifier, for: indexPath) as! ProductMainCellOne
//            cell.configure(with: product.mainImage)
            cell.setCustomImage(image: product.mainImage!)
            return cell
        } else if indexPath.row == 1 {
            // show label cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductMainCellTwo.identifier, for: indexPath) as! ProductMainCellTwo
            cell.configure(with: product)
            return cell
        }
        // show info cell
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductMainCellThree.identifier, for: indexPath) as! ProductMainCellThree
        
        if let detailImage = product.descImages[indexPath.row - 2] {
            cell.setCustomImage(image: detailImage)
            return cell
        }
//        cell.configure(with: detailImage)
        
        return UITableViewCell()
    }

    
}

