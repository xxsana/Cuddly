//
//  OrderViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/25.
//

import UIKit

class OrderViewController: UIViewController {

    // MARK: - Properties
    
    var navigation: CustomNavigation!
    var orderItems: [CartItem]!
    
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var goToPGButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var basicAddressField: UITextField!
    @IBOutlet weak var detailAddressField: UITextField!
    @IBOutlet weak var orderMemo: UITextField!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        
        tableDelegate()
        
        setTotalPrice()
        
        adjustTableViewHeight()

    }
    
    
    // MARK: - Helper
    
    func configureNavigation() {
        navigation = CustomNavigation(superVC: self)
        navigation.initBackButton()
        navigation.setTitle(as: "결제")
    }
    
    func tableDelegate() {
        itemTableView.delegate = self
        itemTableView.dataSource = self
    }
    
    func adjustTableViewHeight() {
        tableViewHeightConstraint.constant = ( 61.0 * CGFloat(orderItems.count))
        self.view.layoutIfNeeded()
    }
    
    func setTotalPrice() {
        var totalPrice = 0
        
        for item in orderItems {
            totalPrice += (item.price * item.count)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let formattedPrice = formatter.string(from: NSNumber(value: totalPrice)) else { return }
        
        totalPriceLabel.text = "\(formattedPrice)원"
    }

}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG: orderItems.count - \(orderItems.count)")
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.id, for: indexPath) as! OrderCell
        cell.configure(orderItems[indexPath.row])
        return cell
    }
    
    
}
