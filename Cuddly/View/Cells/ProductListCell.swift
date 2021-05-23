//
//  ProductListCell.swift
//  Cuddly
//
//  Created by Haru on 2021/05/19.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = K.id.productListCell
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true

     }
    
    // MARK: - Helpers
    
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
