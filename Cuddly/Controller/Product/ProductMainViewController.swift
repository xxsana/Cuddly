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
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hideTabBar()
        
        configureNavigation()
        
        configureUI()
        
        tableViewDelegate()
        
        tableRegister()
        
    }


    // MARK: - IBActions
    @IBAction func countChanged(_ sender: UIStepper) {
        let count = Int(sender.value)
        let price: Int = product.price * count
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) else { return }
        
        countLabel.text = "\(count) 개"
        priceLabel.text = "\(formattedPrice)원"
    }
    
    @IBAction func addToCartButtonClicked(_ sender: UIButton) {
        let id = product.productID
        let count = Int(countStepper.value)
        let price = product.price
        
        if count == 0 {
            // alert "수량을 선택해주세요"
            let alertVC = UIAlertController(title: "수량을 선택해주세요", message: nil, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertVC, animated: true, completion: nil)
            return
            
        } else {
            CartService.shared.uploadToCart(productID: id, count: count, price: price) { error, ref in
                print("DEBUG: saved product to cart")
                // alert "장바구니에 담겼습니다"
                let alertVC = UIAlertController(title: "장바구니에 담겼습니다!", message: nil, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                
                // stepper value 0
                self.countStepper.value = 0
                self.countLabel.text = "0 개"
                self.priceLabel.text = "0원"
            }
        }
    }
    
    

    // MARK: - Helpers
    
    func hideTabBar() {
        let tabBar = self.tabBarController as! MainTabController
        tabBar.hideTabBar()
    }
    
    func configureNavigation() {
        // create custom navigation
        navigation = CustomNavigation(superVC: self)
        navigation.initBackButton(showTab: true)
        navigation.initCartButton()
    }
    
    func configureUI() {
        // purchase button round border
        addToCartButton.layer.cornerRadius = 8.0
        addToCartButton.clipsToBounds = true
        
        // table autolayout
        tableView.contentInsetAdjustmentBehavior = .never
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
            if let image = product.mainImage {
                cell.setCustomImage(image: image)
            }
            return cell
            
        } else if indexPath.row == 1 {
            
            // show label cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductMainCellTwo.identifier, for: indexPath) as! ProductMainCellTwo
            cell.configure(with: product)
            return cell
            
        } else {
            
            // show info cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductMainCellThree.identifier, for: indexPath) as! ProductMainCellThree
            
            if let detailImage = product.descImages[indexPath.row - 2] {
                cell.setCustomImage(image: detailImage)
                return cell
            }
        }
   
        
        return UITableViewCell()
    }

    
}

