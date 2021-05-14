//
//  LogInViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/14.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var logInButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers

    func configureUI() {
        // round corner of log in button
        logInButton.layer.masksToBounds = true
        logInButton.layer.cornerRadius = 5
    }
}
