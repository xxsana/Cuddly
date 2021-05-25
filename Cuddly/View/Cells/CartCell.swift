//
//  CartCell.swift
//  Cuddly
//
//  Created by Haru on 2021/05/24.
//

import UIKit

//protocol CartSelectDelegate: UIViewController {
//    func refreshPriceLabel()
//}

class CartCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var preimageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var selectItem: (() -> ())?
    var unselectItem: (() -> ())?
    
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // select unselect button image
        let emptyImage = circleImage(name: K.emptyCircle)
        selectButton.setImage(emptyImage, for: .normal)
        
        let checkedImage = circleImage(name: K.checkedCircle)
        selectButton.setImage(checkedImage, for: .selected)
        
        // round image border
        preimageView.layer.cornerRadius = 7.0
        preimageView.clipsToBounds = true

    }
    
    // MARK: - Helpers
    
    func configure(product : Product, count: Int) {
        preimageView.image = product.mainImage
        countLabel.text = "\(count)"
        nameLabel.text = product.name

        let price: Int = product.price * count
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) else { return }
        priceLabel.text = "\(formattedPrice)원"
    }
    
    func circleImage(name: String) -> UIImage? {
        UIImage(systemName: name,
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular))
    }

    
    // MARK: - IBActions
    
    @IBAction func selectButtonClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            // if it was already checked
            sender.isSelected = false
            self.unselectItem?()

        } else {
            // if it was empty
            sender.isSelected = true
            self.selectItem?()
        }
    }
}
