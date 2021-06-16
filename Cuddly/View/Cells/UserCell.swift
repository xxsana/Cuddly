//
//  UserCell.swift
//  Cuddly
//
//  Created by Haru on 2021/05/19.
//

import UIKit

class UserCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var settingIcon: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    
    static let id = "UserCell"
    
    // MARK: - Helpers
    func configure(_ icon: String, _ label: String) {
        settingIcon.image = UIImage(systemName: icon)
        settingLabel.text = label
    }

}
