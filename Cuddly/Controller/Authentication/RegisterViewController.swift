//
//  RegisterViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/14.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .black
        
        self.emailTextField.becomeFirstResponder()
        
        setTextFieldsDelegate()
    }
    
    // MARK: - API
    
    func registerInAction() {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let userName = userNameTextField.text  else {print("DEBUG: emptied any text field"); return}

        let credentials = AuthCredentials(email: email, password: password, userName: userName)
        
        // register user and push Recipe Main if it succeed.
        AuthService.shared.registerUser(credentials: credentials) { error, reference in
        
            guard let tabVC = self.storyboard?.instantiateViewController(withIdentifier: K.id.customTabBar) else {return}
            self.navigationController?.pushViewController(tabVC, animated: true)
        }
    }

    // MARK: - Selectors
    
    @IBAction func registerInButtonClicked(_ sender: UIButton) {
        registerInAction()
    }
    
    // MARK: - Helpers
 
    func setTextFieldsDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.delegate = self
    }
}


// MARK: - Extension Text Field Delegate

extension RegisterViewController: UITextFieldDelegate {
    
    // return key user interface
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Current Tag: \(textField.tag)")
        if textField.placeholder == "email" {
            // user returned on email text field
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            
        } else if textField.placeholder == "password" {
            // user returned on password text field
            userNameTextField.becomeFirstResponder()
            
        } else {
            // user returned on user name text field
            registerInAction()
        }
        
        return true
    }
    
    // for the keyboard go away when user touches outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
