//
//  LogInViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/14.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateUser()
        
        setTextFieldsDelegate()
        
        navigationController?.navigationBar.isHidden = true
        
        // 로그인 되어 있을 때 넘어갈 때 더 깔끔해 보이게 키보드 안보이게 함
//        self.emailTextField.becomeFirstResponder(
    }
    
    // MARK: - Action Outlets
    @IBAction func logInButtonClicked(_ sender: UIButton) {
        logInAction()
    }
    
    // MARK: - API
    
    func authenticateUser() {
        if Auth.auth().currentUser != nil {
            
            // already log in
            guard let tabVC = storyboard?.instantiateViewController(withIdentifier: K.id.customTabBar) else {return}
            navigationController?.pushViewController(tabVC, animated: true)
        }
    }
    
    func logInAction() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let e = error {
                // if there is error
                print("DEBUG: \(e.localizedDescription)")
                
            } else {
                // successfully logged in
                guard let tabVC = self.storyboard?.instantiateViewController(withIdentifier: K.id.customTabBar) else {return}
                self.navigationController?.pushViewController(tabVC, animated: true)
                
            }
        }
    }
    
    // MARK: - Helpers
    
    func setTextFieldsDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - Extension Text Field Delegate

extension LogInViewController: UITextFieldDelegate {
    
    // return key user interface
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.placeholder == "email" {
            
            // user returned on email text field
            passwordTextField.becomeFirstResponder()
            
        } else {
            // user returned on password text field
            logInAction()
            
        }
        return true
    }
    
    // for the keyboard go away when user touches outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
