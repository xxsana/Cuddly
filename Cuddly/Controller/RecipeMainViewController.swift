//
//  RecipeMainViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/03/26.
//

import UIKit

class RecipeMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // line UI
        let lineViewAbove = UIView(frame: CGRect(x: 20, y: 560, width: 374, height: 1.2))
        lineViewAbove.layer.borderWidth = 374
        lineViewAbove.layer.borderColor = CGColor.init(red: 0.8627, green: 0.8627, blue: 0.8627, alpha: 1)
        
        let lineViewBelow = UIView(frame: CGRect(x: 20, y: 648, width: 374, height: 1.2))
        lineViewBelow.layer.borderWidth = 374
        lineViewBelow.layer.borderColor = CGColor.init(red: 0.8627, green: 0.8627, blue: 0.8627, alpha: 1)
        
        self.view.addSubview(lineViewAbove)
        self.view.addSubview(lineViewBelow)
    }
    
}
