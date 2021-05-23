//
//  ProductMainCellThree.swift
//  Cuddly
//
//  Created by Haru on 2021/05/22.
//

import UIKit

class ProductMainCellThree: UITableViewCell {

    @IBOutlet weak var detailImageView: UIImageView!
    
    static let identifier = "ProductMainCellThree"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProductMainCellThree", bundle: nil)
    }
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                detailImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                detailImageView.addConstraint(aspectConstraint!)
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }

    func setCustomImage(image : UIImage) {

        let aspect = image.size.width / image.size.height

        let constraint = NSLayoutConstraint(item: detailImageView as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: detailImageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
        
        constraint.priority = UILayoutPriority(rawValue: 999)

        aspectConstraint = constraint

        detailImageView.image = image
    }
    
    
    
//    public func configure(with image: UIImage?) {
//        self.detailImageView.image = image
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
