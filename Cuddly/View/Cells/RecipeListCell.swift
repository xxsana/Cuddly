//
//  RecipeListCell.swift
//  Cuddly
//
//  Created by Haru on 2021/05/13.
//

import UIKit

class RecipeListCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let identifier = K.id.recipeListCell
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true

     }
    
    // MARK: - Helpers
    
    // configure value
    public func configure(with recipe: Recipe) {
        imageView.image = recipe.image
        subtitleLabel.text = recipe.subtitle
        titleLabel.text = recipe.title
        timeLabel.text = recipe.time
    }
    
    // nib initialize
    static func nib() -> UINib {
        return UINib(nibName: K.id.recipeListCell, bundle: nil)
    }
    

}
