//
//  ProductMainCellOne.swift
//  Cuddly
//
//  Created by Haru on 2021/05/22.
//

import UIKit

class ProductMainCellOne: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    
    static let identifier = "ProductMainCellOne"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProductMainCellOne", bundle: nil)
    }
    
//    public func configure(with image: UIImage?) {
//        self.mainImageView.image = image
//    }
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                mainImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                mainImageView.addConstraint(aspectConstraint!)
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }

    func setCustomImage(image : UIImage) {

        let aspect = image.size.width / image.size.height

        let constraint = NSLayoutConstraint(item: mainImageView as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainImageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
        
        constraint.priority = UILayoutPriority(rawValue: 999)

        aspectConstraint = constraint

        mainImageView.image = image
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
