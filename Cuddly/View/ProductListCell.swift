//
//  ProductListCell.swift
//  Cuddly
//
//  Created by Haru on 2021/05/19.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = K.id.productListCell
    
    // configure value
    public func configure(with product: Product) {
        imageView.image = product.mainImage
        nameLabel.text = product.name
        priceLabel.text = "\(product.price)원"
    }
    
    // nib initialize
    static func nib() -> UINib {
        return UINib(nibName: K.id.productListCell, bundle: nil)
    }

}
