//
//  CartViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/24.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: - Properties

    var cart = Cart.sharedCart
    var navigation: CustomNavigation!
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("DEBUG: in Cart VC cart: \(cart)")
        
        configureNavigation()
        
        hideTabBar()
     
        setDelegate()
        
        configureUI()

    }
    
    
    // MARK: - Helper
    
    func configureNavigation() {
        navigation = CustomNavigation(superVC: self)
        navigation.initBackButton(showTab: true)
        navigation.setTitle(as: "장바구니")
    }
    
    func hideTabBar() {
        let tabBar = self.tabBarController as! MainTabController
        tabBar.hideTabBar()
    }
    
    func setDelegate() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
    }
    
    func configureUI() {
        // buy button round border
        buyButton.layer.cornerRadius = 8.0
        buyButton.clipsToBounds = true
    }
    
    func refreshPriceLabel() {
        var totalPrice = 0
        for item in cart {
            if item.selected {
                totalPrice += ( item.price * item.count )
            }
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formatted = formatter.string(from: NSNumber(value: totalPrice)) {
            totalPriceLabel.text = "\(formatted)원"
        }
    }

}

// MARK: - Table View Extenstion
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cartItem = cart[indexPath.row]
        let productID = cartItem.productID
        
        if let product = Product.findProduct(with: productID) {
            let count = cartItem.count
            let cell = cartTableView.dequeueReusableCell(withIdentifier: K.id.cartCell, for: indexPath) as! CartCell
            
            cell.configure(product: product, count: count)
            cell.selectItem = {
                self.cart[indexPath.row].selected = true
                self.refreshPriceLabel()
            }
            cell.unselectItem = {
                self.cart[indexPath.row].selected = false
                self.refreshPriceLabel()
            }
            
            return cell
        }

        return UITableViewCell()
    }
}
