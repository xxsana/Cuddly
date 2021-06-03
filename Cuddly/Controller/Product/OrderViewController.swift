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
    let defaults = UserDefaults.standard
    
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
        
        setDelegate()
        
        setTotalPrice()
        
        adjustTableViewHeight()
        
        buttonUI()

        fetchRecentAddress()
    }
    
    // MARK: - IBAction
    
    @IBAction func goToPGButtonClicked(sender: UIButton) {
        
        if nameField.text?.isEmpty ?? true || phoneField.text?.isEmpty ?? true ||
            basicAddressField.text?.isEmpty ?? true || detailAddressField.text?.isEmpty ?? true {
            
            // Some textField is empty
            // alert "배송지 정보를 모두 작성 해 주세요."
            let alertVC = UIAlertController(title: "배송지 정보를 모두 작성 해 주세요.", message: nil, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)

        } else {
            
            // Textfield empty check succeed.
            // upload address to firebase
            guard let name = nameField.text,
                  let phone = phoneField.text,
                  let basicAddress = basicAddressField.text,
                  let detailAddress = detailAddressField.text,
                  let memo = orderMemo.text else { return }
            
            let addressDict = [K.Firebase.realName : name,
                               K.Firebase.phoneNumber : phone,
                               K.Firebase.basicAddress : basicAddress,
                               K.Firebase.detailAddress : detailAddress]
            
            // upload to firebase
            UserService.shared.uploadAddress(addressDict) { error, ref in
                
                if let e = error {
                    print(e.localizedDescription)
                }
                
                // save to user defaults
                UserDefaultsService.shared.saveAddress(addressDict)
            }
        }
    }
    
    func fetchRecentAddress() {
        
        let recentAddress = UserDefaultsService.shared.fetchAddressFromUserDefaults()
        
        fillTextFieldWithRecentAddress(recentAddress)
    }
    
    
    // MARK: - Helper
    
    func configureNavigation() {
        navigation = CustomNavigation(superVC: self)
        navigation.initBackButton()
        navigation.setTitle(as: "결제")
    }
    
    func setDelegate() {
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        nameField.delegate = self
        phoneField.delegate = self
        detailAddressField.delegate = self
        basicAddressField.delegate = self
        orderMemo.delegate = self
    }
    
    func adjustTableViewHeight() {
        tableViewHeightConstraint.constant = ( 61.0 * CGFloat(orderItems.count))
        self.view.layoutIfNeeded()
    }
    
    func buttonUI() {
        // purchase button round border
        goToPGButton.layer.cornerRadius = 8.0
        goToPGButton.clipsToBounds = true
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
    
    func fillTextFieldWithRecentAddress(_ dict: [String : String]) {
        nameField.text = dict[K.Firebase.realName]
        phoneField.text = dict[K.Firebase.phoneNumber]
        basicAddressField.text = dict[K.Firebase.basicAddress]
        detailAddressField.text = dict[K.Firebase.detailAddress]
    }

}

// MARK: - Extension Table View

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.id, for: indexPath) as! OrderCell
        cell.configure(orderItems[indexPath.row])
        return cell
    }
}


// MARK: - Extension Text Field Delegate

extension OrderViewController: UITextFieldDelegate {
    
    // return key user interface
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 4  {
            // the last textfield
            textField.resignFirstResponder()
        } else {
            let currentTag = textField.tag
            self.view.viewWithTag(currentTag + 1)?.becomeFirstResponder()
        }
        
        return true
    }
}
