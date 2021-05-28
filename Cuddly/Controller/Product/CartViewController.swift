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
        
        configureNavigation()
        
        hideTabBar()
     
        setDelegate()
        
        configureUI()

    }
    
    // MARK: - IBActions
    
    @IBAction func buyButtonClicked(_ sender: Any) {
        
        // selected item만 추려서 order array 만들고
        var orderItems = [CartItem]()
        
        for item in cart {
            if item.selected {
                orderItems.append(item)
            }
        }
        
        if orderItems.isEmpty {
            // none selected - present alert
            let alertVC = UIAlertController(title: "선택된 제품이 없습니다.", message: nil, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
            return
        }
        
        // if it's not empty, pass value and push view controller
        
        let vc = storyboard?.instantiateViewController(withIdentifier: K.id.orderVC) as! OrderViewController
        vc.orderItems = orderItems
        navigationController?.pushViewController(vc, animated: true)
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
        
        guard let product = Product.findProduct(with: productID) else {
            return UITableViewCell() }
        
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
}
