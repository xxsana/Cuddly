//
//  BookmarkCell.swift
//  Cuddly
//
//  Created by Haru on 2021/06/01.
//

import UIKit

class BookmarkCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    
    static let id = "BookmarkCell"
    
    func configure(with recipe: Recipe) {
        mainImageView?.image = recipe.image
        subtitleLabel?.text = recipe.subtitle
        titleLabel?.text = recipe.title
        timeLabel?.text = recipe.time
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    
        // rounded image view 
        mainImageView?.layer.cornerRadius = 7.0
        mainImageView?.clipsToBounds = true
    }
    
}
