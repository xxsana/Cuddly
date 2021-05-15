//
//  LogInViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/14.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Selectors
    @IBAction func logInButtonClicked(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let e = error {
                // if there is error
                print("DEBUG: \(e.localizedDescription)")
                
            } else {
                
                // successfully logged in
                // use root view controller's method
                // get key window
                guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
                
                // get root vc
                guard let tab = keyWindow.rootViewController as? CustomTabBarController else {return}
                
                tab.authenticateUserAndConfigureUI()
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - Helpers

}
