//
//  ProductMainCellTwo.swift
//  Cuddly
//
//  Created by Haru on 2021/05/22.
//

import UIKit

class ProductMainCellTwo: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var showCouponButton: UIButton!
    
    static let identifier = "ProductMainCellTwo"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProductMainCellTwo", bundle: nil)
    }
    
    public func configure(with product: Product) {
        self.nameLabel.text = product.name
        self.priceLabel.text = "\(product.price)원"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        showCouponButton.layer.borderWidth = 1.0
        showCouponButton.layer.borderColor = CGColor(gray: 0.0, alpha: 1.0)
        showCouponButton.layer.cornerRadius = 7.0
        showCouponButton.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
