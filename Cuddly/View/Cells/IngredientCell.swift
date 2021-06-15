//
//  IngredientCell.swift
//  Cuddly
//
//  Created by Haru on 2021/06/15.
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    static let id = "IngredientCell"
    
    func configure(with ingredient: Ingredient) {
        self.nameLabel.text = ingredient.name
        self.weightLabel.text = ingredient.weight
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "IngredientCell", bundle: nil)
    }
    
}
