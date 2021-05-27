//
//  OrderCell.swift
//  Cuddly
//
//  Created by Haru on 2021/05/26.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let id = "OrderCell"
    
    func configure(_ item: CartItem) {
        let product = Product.findProduct(with: item.productID)
        
        nameLabel.text = product?.name
        countLabel.text = "\(item.count)"
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedPrice = formatter.string(from: NSNumber(value: item.price)) {
            priceLabel.text = "\(formattedPrice)원"
        }
    }
}
